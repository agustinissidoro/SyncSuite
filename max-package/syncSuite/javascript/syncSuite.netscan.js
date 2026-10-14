/**
 * syncSuite.netscan.js
 *
 * Own IP/mask lookup + subnet discovery via a two-pass ICMP ping sweep
 * backed by the OS's ARP table, so devices that don't answer ping still show
 * up (protocol-agnostic: tells you "a device is here", not "OSC/TCP works
 * here" — actual UDP/TCP reachability per host is a separate, later concern).
 *
 * node.script has exactly 2 fixed outlets — outlet 0 carries anything sent
 * with Max.outlet(), outlet 1 is stdout/stderr/status only. There's no
 * per-call outlet index and no way to add more outlets. So everything goes
 * out outlet 0, prepended with a command tag so you can parse/route it
 * downstream (e.g. with [route myip scan done]):
 *
 * Out (outlet 0, always tagged):
 *   myip <iface> <ip> <mask> [internal|external]
 *   scan <iface> <host1> <host2> ...   (or "scan <iface> none")
 *   ping <ip> <0|1>                    (1 = answered, 0 = did not)
 *   done                                (sent after each myip/scan/ping report)
 *
 * In:  "myip"              -> reports every active non-internal IPv4
 *                             interface (all of them, if you're on more
 *                             than one network), then sends "done"
 *      "myip all"          -> same, "... internal|external" appended,
 *                             includes internal/loopback interfaces too
 *      "scan <ip> <mask>"  -> sweeps that subnet, reports the result, then sends "done"
 *      "scan"              -> scans EVERY active interface's own subnet in
 *                             turn, each with its own report + "done"
 *      "ping <ip>"         -> pings that single host, reports "ping <ip> <0|1>",
 *                             then sends "done"
 *
 * Startup args: [node.script syncSuite.netscan.js <ip> <mask>] immediately
 * runs "scan <ip> <mask>" once the script loads.
 */

const { execFile } = require('child_process');
const os = require('os');
const Max = require('max-api');

function ipToInt(ip) {
  return ip.split('.').reduce((acc, oct) => (acc << 8) + parseInt(oct, 10), 0) >>> 0;
}

function intToIp(int) {
  return [24, 16, 8, 0].map(shift => (int >>> shift) & 255).join('.');
}

// Returns every active non-internal IPv4 interface (there can be more than
// one at once, e.g. Wi-Fi + Ethernet + a VPN adapter).
function allIPv4(includeInternal = false) {
  const ifaces = os.networkInterfaces();
  const result = [];
  for (const name of Object.keys(ifaces)) {
    for (const iface of ifaces[name]) {
      if (iface.family === 'IPv4' && (includeInternal || !iface.internal)) {
        result.push({ ip: iface.address, mask: iface.netmask, iface: name, internal: iface.internal });
      }
    }
  }
  return result;
}

function hostsInRange(ip, mask) {
  const ipInt = ipToInt(ip);
  const maskInt = ipToInt(mask);
  const network = ipInt & maskInt;
  const broadcast = network | (~maskInt >>> 0);
  const hosts = [];
  for (let i = network + 1; i < broadcast; i++) {
    hosts.push(intToIp(i));
  }
  return hosts;
}

function isIPv4(str) {
  if (typeof str !== 'string') return false;
  const parts = str.split('.');
  return parts.length === 4 && parts.every(p => /^\d{1,3}$/.test(p) && parseInt(p, 10) <= 255);
}

// A netmask is a run of 1-bits followed by a run of 0-bits, nothing else.
function isMask(str) {
  if (!isIPv4(str)) return false;
  const inv = ~ipToInt(str) >>> 0;
  return (inv & (inv + 1)) === 0;
}

// Anything wider than a /16 is 65k+ hosts: minutes of sweeping at best, and
// a typo'd mask (0.0.0.0) would try to build a list of the whole internet.
const MIN_MASK = ipToInt('255.255.0.0');

function checkSubnet(ip, mask) {
  if (!isIPv4(ip)) return `"${ip}" is not an IPv4 address`;
  if (!isMask(mask)) return `"${mask}" is not a valid netmask`;
  if (ipToInt(mask) < MIN_MASK) return `mask ${mask} is too wide, 255.255.0.0 is the widest allowed`;
  return null;
}

// One ping subprocess, `count` echo requests `intervalS` apart, waiting
// `waitMs` for each reply; resolves true if at least one came back. -W is
// milliseconds on macOS, whole seconds on Linux (note: macOS's -t sets IP
// TTL, not a timeout — do not use it here for that purpose). 0.2 is the
// lowest -i macOS/Linux allow non-root users.
function pingHost(ip, { count = 2, intervalS = 0.2, waitMs = 800 } = {}) {
  return new Promise((resolve) => {
    const platform = os.platform();
    // Generous: only there to reap a ping that hangs, never to cut a live one short.
    const timeout = (count - 1) * intervalS * 1000 + waitMs + 3000;
    if (platform === 'win32') {
      // Windows ping exits 0 on "Destination host unreachable" too, so look
      // for an actual echo reply instead of trusting the exit code.
      execFile('ping', ['-n', String(count), '-w', String(waitMs), ip], { timeout },
        (err, stdout) => resolve(/TTL=/i.test(String(stdout))));
      return;
    }
    const args = platform === 'darwin'
      ? ['-c', String(count), '-i', String(intervalS), '-W', String(waitMs), '-o', ip] // -o: exit on first reply
      : ['-c', String(count), '-i', String(intervalS), '-W', String(Math.max(1, Math.ceil(waitMs / 1000))), ip];
    execFile('ping', args, { timeout }, (err) => resolve(!err));
  });
}

function run(cmd, args) {
  return new Promise((resolve) => {
    execFile(cmd, args, { timeout: 5000 }, (err, stdout) => resolve(err ? null : String(stdout)));
  });
}

// Every IPv4 address the OS currently holds a resolved hardware address for.
// A device has to answer ARP to be on the network at all, so this catches
// the ones that drop ICMP echo (Windows' default firewall, many phones,
// some embedded gear) or that answered too late for ping to notice.
async function arpNeighbors() {
  const found = new Set();
  const platform = os.platform();

  if (platform === 'win32') {
    //   192.168.0.12          aa-bb-cc-dd-ee-ff     dynamic
    const out = await run('arp', ['-a']);
    for (const line of (out || '').split('\n')) {
      const m = line.match(/^\s*(\d+\.\d+\.\d+\.\d+)\s+([0-9a-f]{2}(?:-[0-9a-f]{2}){5})\s+dynamic/i);
      if (m) found.add(m[1]);
    }
    return found;
  }

  if (platform === 'linux') {
    // 192.168.0.12 dev eth0 lladdr aa:bb:cc:dd:ee:ff REACHABLE
    // STALE/DELAY/PROBE/FAILED are entries nobody has confirmed since the
    // sweep touched them, i.e. most likely devices that already left.
    const out = await run('ip', ['-4', 'neigh', 'show']);
    if (out !== null) {
      for (const line of out.split('\n')) {
        const m = line.match(/^(\d+\.\d+\.\d+\.\d+) .*lladdr \S+ .*\b(REACHABLE|PERMANENT)\b/);
        if (m) found.add(m[1]);
      }
      return found;
    }
  }

  // macOS (and Linux without iproute2). -l adds the expiry columns on macOS:
  // 192.168.0.12   aa:bb:cc:dd:ee:ff   1m48s   1m48s   en0   1
  // An entry expired both ways after we just pinged it is a leftover.
  let out = platform === 'darwin' ? await run('arp', ['-anl']) : null;
  if (out !== null) {
    for (const line of out.split('\n')) {
      const [ip, mac, expO, expI] = line.trim().split(/\s+/);
      if (!isIPv4(ip) || !/^[0-9a-f]{1,2}(:[0-9a-f]{1,2}){5}$/i.test(mac || '')) continue;
      if (expO === 'expired' && expI === 'expired') continue;
      found.add(ip);
    }
    return found;
  }
  // ? (192.168.0.12) at aa:bb:cc:dd:ee:ff on en0 ifscope [ethernet]
  out = await run('arp', ['-an']);
  for (const line of (out || '').split('\n')) {
    const m = line.match(/\((\d+\.\d+\.\d+\.\d+)\) at ([0-9a-f]{1,2}(?::[0-9a-f]{1,2}){5})\b/i);
    if (m) found.add(m[1]);
  }
  return found;
}

// Pings every host in `hosts`, at most `concurrency` at once; returns the
// ones that answered.
async function sweep(hosts, concurrency, pingOpts) {
  const alive = [];
  let idx = 0;

  async function worker() {
    while (idx < hosts.length) {
      const target = hosts[idx++];
      if (await pingHost(target, pingOpts)) alive.push(target);
    }
  }

  await Promise.all(Array.from({ length: concurrency }, worker));
  return alive;
}

async function scan(ip, mask, iface = ip) {
  const hosts = hostsInRange(ip, mask);
  const alive = new Set();

  // Our own addresses are up by definition, no need to ask the network.
  const own = new Set(allIPv4().map(info => info.ip));
  for (const host of hosts) if (own.has(host)) alive.add(host);

  // Pass 1: quick sweep, ~1s per silent host.
  let pending = hosts.filter(h => !alive.has(h));
  for (const h of await sweep(pending, 64, { count: 2, intervalS: 0.2, waitMs: 800 })) alive.add(h);

  // Pass 2: everyone who stayed silent gets a second, slower chance. The OS
  // only re-sends an unanswered ARP request about once a second, so pass 1's
  // ~1s window rides on a single ARP broadcast per host — and broadcasts are
  // exactly what Wi-Fi drops and what sleeping phones/tablets miss. Coming
  // back seconds later with a 2s window gives each host several more.
  pending = hosts.filter(h => !alive.has(h));
  for (const h of await sweep(pending, 128, { count: 2, intervalS: 1, waitMs: 1000 })) alive.add(h);

  // Pass 3: hosts that resolved over ARP during the sweep but never returned
  // an echo reply (ICMP filtered, or the reply came in too late).
  const wanted = new Set(hosts);
  for (const h of await arpNeighbors()) if (wanted.has(h)) alive.add(h);

  const result = [...alive].sort((a, b) => ipToInt(a) - ipToInt(b));
  Max.outlet('scan', iface, ...(result.length ? result : ['none']));
  Max.outlet('done');
}

// Scans run one at a time: two overlapping sweeps (e.g. the on-load scan and
// a manual one) would double the burst of traffic and cost both accuracy.
let scanQueue = Promise.resolve();

function queueScan(ip, mask, iface) {
  scanQueue = scanQueue
    .then(() => scan(ip, mask, iface))
    .catch(e => Max.post('scan error: ' + e.message));
  return scanQueue;
}

Max.addHandler('myip', (mode) => {
  const ifaces = allIPv4(mode === 'all');
  if (!ifaces.length) {
    Max.post('myip: no active IPv4 interface found');
    return;
  }
  for (const info of ifaces) {
    if (mode === 'all') {
      Max.outlet('myip', info.iface, info.ip, info.mask, info.internal ? 'internal' : 'external');
    } else {
      Max.outlet('myip', info.iface, info.ip, info.mask);
    }
  }
  Max.outlet('done');
});

Max.addHandler('ping', (ip) => {
  ip = String(ip === undefined ? '' : ip);
  if (!isIPv4(ip)) {
    Max.post('ping: need an ip, e.g. ping 192.168.0.12');
    return;
  }
  pingHost(ip).then(alive => {
    Max.outlet('ping', ip, alive ? 1 : 0);
    Max.outlet('done');
  }).catch(e => Max.post('ping error: ' + e.message));
});

Max.addHandler('scan', (ip, mask) => {
  if (ip !== undefined || mask !== undefined) {
    const problem = checkSubnet(String(ip), String(mask));
    if (problem) {
      Max.post('scan: ' + problem + ', e.g. scan 192.168.0.1 255.255.255.0');
      return;
    }
    queueScan(String(ip), String(mask));
    return;
  }
  const ifaces = allIPv4();
  if (!ifaces.length) {
    Max.post('scan: no ip/mask given and no active IPv4 interface found');
    return;
  }
  for (const info of ifaces) {
    const problem = checkSubnet(info.ip, info.mask);
    if (problem) Max.post(`scan: skipping ${info.iface}, ${problem}`);
    else queueScan(info.ip, info.mask, info.iface);
  }
});

// [node.script syncSuite.netscan.js <ip> <mask>] -> scan immediately on load
const [, , startIp, startMask] = process.argv;
if (startIp && startMask) {
  const problem = checkSubnet(startIp, startMask);
  if (problem) Max.post('scan: ' + problem);
  else queueScan(startIp, startMask);
}
