/**
 * syncSuite.netscan.js
 *
 * Own IP/mask lookup + subnet discovery via ICMP ping sweep (protocol-
 * agnostic: tells you "a device answered here", not "OSC/TCP works here" —
 * actual UDP/TCP reachability per host is a separate, later concern).
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
 *      "scan <ip> <mask>"  -> pings that subnet, reports the result, then sends "done"
 *      "scan"              -> scans EVERY active interface's own subnet in
 *                             turn, each with its own report + "done"
 *      "ping <ip>"         -> pings that single host, reports "ping <ip> <0|1>",
 *                             then sends "done"
 *
 * Startup args: [node.script syncSuite.netscan.js <ip> <mask>] immediately
 * runs "scan <ip> <mask>" once the script loads.
 */

const { exec } = require('child_process');
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

// -c 2: two attempts, so one dropped packet doesn't read as "dead" (ping's
// exit code is 0 if AT LEAST one reply came back). -W is the per-reply wait:
// milliseconds on macOS, whole seconds on Linux (note: macOS's -t sets IP
// TTL, not a timeout — do not use it here for that purpose).
function pingHost(ip, waitMs = 800) {
  return new Promise((resolve) => {
    const isMac = os.platform() === 'darwin';
    const cmd = isMac
      ? `ping -c 2 -W ${waitMs} ${ip}`
      : `ping -c 2 -W ${Math.max(1, Math.ceil(waitMs / 1000))} ${ip}`;
    exec(cmd, { timeout: waitMs * 3 }, (err) => resolve(!err));
  });
}

async function scan(ip, mask, iface = ip) {
  const hosts = hostsInRange(ip, mask);

  const CONCURRENCY = 24;
  const alive = [];
  let idx = 0;

  async function worker() {
    while (idx < hosts.length) {
      const target = hosts[idx++];
      if (await pingHost(target)) alive.push(target);
    }
  }

  await Promise.all(Array.from({ length: CONCURRENCY }, worker));

  alive.sort((a, b) => ipToInt(a) - ipToInt(b));
  Max.outlet('scan', iface, ...(alive.length ? alive : ['none']));
  Max.outlet('done');
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
  if (!ip) {
    Max.post('ping: need an ip, e.g. ping 192.168.0.12');
    return;
  }
  pingHost(ip).then(alive => {
    Max.outlet('ping', ip, alive ? 1 : 0);
    Max.outlet('done');
  }).catch(e => Max.post('ping error: ' + e.message));
});

Max.addHandler('scan', (ip, mask) => {
  if (ip && mask) {
    scan(ip, mask).catch(e => Max.post('scan error: ' + e.message));
    return;
  }
  const ifaces = allIPv4();
  if (!ifaces.length) {
    Max.post('scan: no ip/mask given and no active IPv4 interface found');
    return;
  }
  (async () => {
    for (const info of ifaces) {
      await scan(info.ip, info.mask, info.iface).catch(e => Max.post('scan error: ' + e.message));
    }
  })();
});

// [node.script syncSuite.netscan.js <ip> <mask>] -> scan immediately on load
const [, , startIp, startMask] = process.argv;
if (startIp && startMask) {
  scan(startIp, startMask).catch(e => Max.post('scan error: ' + e.message));
}
