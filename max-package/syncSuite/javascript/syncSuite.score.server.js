/**
 * server.js
 *
 * Wires score.js (state) + commands.js (dispatch) to Express (HTTP),
 * ws (WebSocket), and Node for Max (Max.addHandler / Max.outlet).
 *
 * Standalone test:
 *   npm install
 *   node server.js
 *   -> Max console substitute: type commands via stdin, see below.
 */

const path = require('path');
const fs = require('fs');
const os = require('os');
const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const { PDFDocument } = require('pdf-lib');
const Max = require('max-api');

const { ScoreRegistry } = require('./syncSuite.score.score');
const { makeGlobalCommands, dispatchScoreCommand } = require('./syncSuite.score.commands');

// node.script box argument (e.g. `node.script syncSuite.score.server.js 9090`)
// takes priority over the PORT env var, which takes priority over the default.
const PORT = Number(process.argv[2]) || process.env.PORT || 8080;
const ROOT = __dirname;

function getLocalIP() {
  const ifaces = os.networkInterfaces();
  for (const entries of Object.values(ifaces)) {
    for (const iface of entries) {
      if (iface.family === 'IPv4' && !iface.internal) return iface.address;
    }
  }
  return 'localhost';
}

// Node reports IPv4 clients as "::ffff:<addr>" on a dual-stack socket; strip
// that prefix so `get` reports the plain address.
function normalizeIP(ip) {
  return ip ? ip.replace(/^::ffff:/, '') : ip;
}

const app = express();
app.use('/vendor', express.static(path.join(ROOT, '..', 'html', 'vendor')));

// ---------------------------------------------------------------------
// WebSocket rooms: one Set<ws> per score, tracked on the Score object itself
// (see score.js). broadcast() is registry's only way to reach browsers.
// ---------------------------------------------------------------------
let wss; // assigned after http server is created, referenced by broadcast()

function broadcast(scoreName, message) {
  const score = registry.get(scoreName);
  if (!score) return;
  const data = JSON.stringify(message);
  score.clients.forEach(ws => {
    if (ws.readyState === WebSocket.OPEN) ws.send(data);
  });
}

const registry = new ScoreRegistry({ onBroadcast: broadcast });

// ---------------------------------------------------------------------
// Dynamic HTTP routes per score: viewer page + the PDF itself.
// Express route handlers can't easily be un-registered, so instead of
// app.get() per score, we use ONE catch-all that checks the registry live.
// This also means deleteScore takes effect immediately, no restart needed.
// ---------------------------------------------------------------------
app.get('/:name', (req, res, next) => {
  const score = registry.get(req.params.name);
  if (!score) return next();
  res.sendFile(path.join(ROOT, '..', 'html', 'syncSuite.score.viewer.html'));
});

app.get('/scores/:name/score.pdf', (req, res, next) => {
  const score = registry.get(req.params.name);
  if (!score || !score.state.pdfPath) return next();
  res.sendFile(path.resolve(score.state.pdfPath));
});

app.get('/api/scores', (req, res) => {
  res.json(registry.all().map(s => ({ name: s.name, ...s.state })));
});

// addScoreRoute/removeScoreRoute are no-ops here since the catch-all routes
// above check the registry live — kept as hooks in case that changes.
const addScoreRoute = () => {};
const removeScoreRoute = () => {};

function reloadAllClients() {
  registry.all().forEach(score => broadcast(score.name, { type: 'reload' }));
}

const globalCommands = makeGlobalCommands({ registry, addScoreRoute, removeScoreRoute, reloadAllClients });

// ---------------------------------------------------------------------
// HTTP + WebSocket server
// ---------------------------------------------------------------------
const server = http.createServer(app);
wss = new WebSocket.Server({ server });

wss.on('connection', (ws, req) => {
  const url = new URL(req.url, 'http://localhost');
  const name = url.searchParams.get('score');
  const score = registry.get(name);
  if (!score) { ws.close(); return; }

  ws.remoteIP = normalizeIP(req.socket.remoteAddress);
  score.clients.add(ws);
  ws.send(JSON.stringify({ type: 'sync', state: score.state }));
  logDeviceEvent(score, 'connect');
  outletScoreHealth(score);

  ws.on('message', (raw) => {
    let msg;
    try { msg = JSON.parse(raw); } catch { return; }

    if (msg.type === 'pageCount') {
      score.patch({ pageCount: msg.pageCount });
      if (typeof Max !== 'undefined') Max.outlet(score.name, 'pages', msg.pageCount);
    } else if (msg.type === 'deviceInfo') {
      forwardDeviceInfoToMax(score, msg, msg.requestId ? 'response' : 'push');
    } else if (msg.type === 'fullscreenChange') {
      forwardDeviceInfoToMax(score, msg, 'push');
    } else if (msg.type === 'turnPage') {
      if (!score.state.allowPageChange) return;
      const next = score.state.page + msg.delta;
      if (next < 1 || next > score.state.pageCount) return;
      score.patch({ page: next });
      broadcast(score.name, { type: 'page', page: next });
      if (typeof Max !== 'undefined') Max.outlet(score.name, 'currentPage', next);
    }
  });

  ws.on('close', () => {
    score.clients.delete(ws);
    logDeviceEvent(score, 'disconnect');
    outletScoreHealth(score);
  });
});

// `<scoreName> connectedDevices <n>` and `<scoreName> state 1|0` (n > 0),
// fired whenever a device's WebSocket connects or disconnects.
function outletScoreHealth(score) {
  if (typeof Max === 'undefined') return;
  const n = score.clients.size;
  Max.outlet(score.name, 'connectedDevices', n);
  Max.outlet(score.name, 'state', n > 0 ? 1 : 0);
}

// Determines a score's page count directly from the PDF file, right after
// `load`/`read`, instead of waiting for a device to render it and report
// back. That device report (above, `msg.type === 'pageCount'`) still
// happens too and remains the fallback for a PDF pdf-lib can't parse.
async function reportPageCount(score) {
  try {
    const bytes = fs.readFileSync(score.state.pdfPath);
    const pdfDoc = await PDFDocument.load(bytes, { updateMetadata: false, ignoreEncryption: true });
    const count = pdfDoc.getPageCount();
    score.patch({ pageCount: count });
    if (typeof Max !== 'undefined') Max.outlet(score.name, 'pages', count);
    else console.log(`[pages] ${score.name}: ${count}`);
  } catch (err) {
    console.error(`Failed to read page count for '${score.name}':`, err.message);
  }
}

function logDeviceEvent(score, event) {
  if (typeof Max !== 'undefined') {
    Max.outlet('deviceEvent', score.name, event);
  }
}

function forwardDeviceInfoToMax(score, msg, kind) {
  if (typeof Max !== 'undefined') {
    Max.outlet(
      'deviceInfo', score.name, kind,
      msg.screenWidth ?? '', msg.screenHeight ?? '',
      msg.devicePixelRatio ?? '', msg.fullscreen ?? ''
    );
  } else {
    console.log(`[deviceInfo:${kind}] ${score.name}`, msg);
  }
}

server.listen(PORT, () => {
  const ip = getLocalIP();
  registry.setAddress(`${ip}:${PORT}`);
  console.log(`Score server listening on ${registry.serverAddress}`);
  if (typeof Max !== 'undefined') {
    Max.outlet('ip', registry.serverAddress);
    Max.outlet('serverState', 1);
  }
});

server.on('error', (err) => {
  console.error('Server error:', err.message);
  if (typeof Max !== 'undefined') {
    Max.outlet('serverState', 0);
    Max.outlet('error', `server: ${err.message}`);
  }
});

// ---------------------------------------------------------------------
// Node for Max bridge
// ---------------------------------------------------------------------
if (typeof Max !== 'undefined') {
  Object.entries(globalCommands).forEach(([name, fn]) => {
    if (name === 'addScore') return; // registered separately below, so it can also attach the score's own listener
    Max.addHandler(name, (...args) => {
      const result = fn(args);
      if (!result.ok) { Max.outlet('error', result.error); return; }
      // `get`-style commands reply with info lines, prefixed by the score
      // name that was passed as their first argument (e.g. `get violin`).
      if (result.info) result.info.forEach(line => Max.outlet(args[0], ...line));
    });
  });

  // A score's Max handler is keyed by name, so it has to be re-registered
  // under the new name whenever a score is added or renamed (see below).
  function registerScoreHandler(name) {
    Max.addHandler(name, (...args) => {
      const [command, ...rest] = args;
      const score = registry.get(name);
      if (!score) return;
      runOnScore(score, command, rest);
    });
  }

  function runOnScore(score, command, rest) {
    const oldName = score.name;
    const r = dispatchScoreCommand(score, registry, command, rest);
    if (!r.ok) { Max.outlet('error', `${score.name}: ${r.error}`); return; }
    if (r.warning) Max.outlet('warning', `${score.name}: ${r.warning}`);
    if (r.info) r.info.forEach(line => Max.outlet(score.name, ...line));
    if (command === 'load' || command === 'read') reportPageCount(score);
    if (command === 'rename' && score.name !== oldName) {
      Max.removeHandlers(oldName);
      registerScoreHandler(score.name);
      outletScoreHealth(score);
    }
  }

  // addScore must also start listening for that score's own selector.
  Max.addHandler('addScore', (...args) => {
    const [name] = args;
    const result = globalCommands.addScore(args);
    if (!result.ok) { Max.outlet('error', result.error); return; }
    outletScoreHealth(registry.get(name));
    if (result.info) result.info.forEach(line => Max.outlet(name, ...line));
    registerScoreHandler(name);
  });

  // `all <command> ...args` fans a score command out to every registered score.
  Max.addHandler('all', (...args) => {
    const [command, ...rest] = args;
    registry.all().forEach(score => runOnScore(score, command, rest));
  });
} else {
  // Standalone test harness: type commands into stdin the same shape
  // Max would send, e.g.:
  //   addScore violin
  //   violin load ./scores/violin/score.pdf
  //   violin page 2
  console.log('No Max environment detected — type commands via stdin to test, e.g.:');
  console.log('  addScore violin');
  console.log('  violin load /absolute/path/to/score.pdf');
  console.log('  violin page 2');
  console.log('  violin rename firstViolin');
  console.log('  get violin');

  process.stdin.setEncoding('utf8');
  process.stdin.on('data', (line) => {
    const args = line.trim().split(/\s+/).filter(Boolean);
    if (!args.length) return;
    const [selector, ...rest] = args;

    if (globalCommands[selector]) {
      const result = globalCommands[selector](rest);
      if (!result.ok) console.error('error:', result.error);
      else if (result.info) result.info.forEach(line => console.log(rest[0], ...line));
      return;
    }

    const score = registry.get(selector);
    if (score) {
      const [command, ...cmdArgs] = rest;
      const r = dispatchScoreCommand(score, registry, command, cmdArgs);
      if (!r.ok) { console.error('error:', r.error); return; }
      if (r.warning) console.warn('warning:', r.warning);
      if (r.info) r.info.forEach(line => console.log(selector, ...line));
      if (command === 'load' || command === 'read') reportPageCount(score);
      return;
    }

    console.error(`unknown command or score: '${selector}'`);
  });
}

module.exports = { registry };
