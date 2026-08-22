/**
 * commands.js
 *
 * Two dispatch tables:
 *   GLOBAL_COMMANDS  - addScore, deleteScore, restart, refresh (bare form)
 *   SCORE_COMMANDS   - everything sent as `<scoreName> <command> ...args`
 *
 * Every handler here only touches `registry` (score.js) and calls
 * registry.broadcast(name, msg) to push deltas to browsers. No HTTP/WS
 * wiring lives in this file — server.js connects the dots.
 */

function toFlag(v) {
  // Max sends 0/1, "true"/"false", or occasionally another nonzero int
  // (e.g. "black 2"); treat any nonzero number as on, be liberal otherwise.
  if (v === true || v === 'true') return true;
  if (v === false || v === 'false' || v === undefined || v === null || v === '') return false;
  const n = Number(v);
  return Number.isFinite(n) ? n !== 0 : Boolean(v);
}

function toInt(v, fallback = 0) {
  const n = parseInt(v, 10);
  return Number.isFinite(n) ? n : fallback;
}

function toFloat(v, fallback = 0) {
  const n = parseFloat(v);
  return Number.isFinite(n) ? n : fallback;
}

// Positions are normalized floats (0.-1.), anchoring an overlay's center
// as a fraction of the screen.
function toNormalized(v, fallback) {
  return Math.min(1, Math.max(0, toFloat(v, fallback)));
}

function rgbIntToHex(n) {
  const num = toInt(n, 0xff0000);
  return '#' + (num & 0xffffff).toString(16).padStart(6, '0');
}

const path = require('path');

// `registry.serverAddress` ("<ip>:<port>") is set by server.js once the
// HTTP server is listening; null before that.
function scoreAddress(registry, name) {
  return registry.serverAddress ? `${registry.serverAddress}/${name}` : null;
}

// Max's "Copy as Pathname" sometimes prefixes an otherwise-POSIX path with
// the boot volume name, e.g. "Macintosh HD:/Users/name/file.pdf" instead of
// "/Users/name/file.pdf". Strip it so the path resolves on the Node side.
function stripVolumePrefix(filePath) {
  const m = filePath.match(/^[^:/\\]+:(\/.*)$/);
  return m ? m[1] : filePath;
}

// ---------------------------------------------------------------------
// Global commands
// ---------------------------------------------------------------------
function makeGlobalCommands({ registry, addScoreRoute, removeScoreRoute, reloadAllClients }) {
  return {
    // Replies with `info` — outlet lines reporting the fresh score's page,
    // page count (0, since nothing's loaded yet), and — once the server is
    // already running — its full address, e.g. `violin address 192.168.1.5:8080/violin`.
    addScore(args) {
      const [name] = args;
      if (!name) return { ok: false, error: 'addScore requires a name' };
      const result = registry.addScore(name);
      if (!result.ok) return result;
      addScoreRoute(name);
      const score = registry.get(name);
      const info = [['currentPage', score.state.page], ['pages', score.state.pageCount]];
      const address = scoreAddress(registry, name);
      if (address) info.push(['address', address]);
      return { ok: true, info };
    },

    deleteScore(args) {
      const [name] = args;
      if (!name) return { ok: false, error: 'deleteScore requires a name' };
      const result = registry.deleteScore(name);
      if (result.ok) removeScoreRoute(name);
      return result;
    },

    // Reports a score's address, loaded file, current/total page and
    // connected devices. Replies via `info`: an array of outlet lines, each
    // prefixed with the score's name by the caller (server.js), e.g.
    // `violin ip 192.168.1.5:8080/violin`.
    get(args) {
      const [name] = args;
      if (!name) return { ok: false, error: 'get requires a score name' };
      const score = registry.get(name);
      if (!score) return { ok: false, error: `get: score '${name}' does not exist` };
      const address = scoreAddress(registry, name);
      if (!address) return { ok: false, error: 'get: server is not running' };

      const info = [
        ['ip', address],
        ['file', score.state.pdfPath || ''],
        ['currentPage', score.state.page],
        ['pages', score.state.pageCount],
      ];
      score.clients.forEach(ws => {
        info.push(['connectedDevices', ws.remoteIP || 'unknown', 1]);
      });
      return { ok: true, info };
    },

    restart() {
      registry.all().forEach(score => {
        score.reset();
        registry.broadcast(score.name, { type: 'sync', state: score.state });
      });
      reloadAllClients();
      return { ok: true };
    },

    refresh() {
      reloadAllClients();
      return { ok: true };
    },
  };
}

// ---------------------------------------------------------------------
// Timer tick loop — the browser is a dumb renderer, so the server owns the
// running clock and pushes a fresh `timerValue` every second, same as any
// other state field. Stops itself (and flips `timerRunning` off) once a
// count-up with a duration reaches it, or a countdown reaches 0.
// ---------------------------------------------------------------------
function startTimerTicking(score, registry) {
  score.stopTimer();
  score.timerHandle = setInterval(() => {
    const dir = score.state.timerDirection;
    let value = score.state.timerValue + dir;
    let running = true;
    if (dir === -1 && value <= 0) {
      value = 0;
      running = false;
    } else if (dir === 1 && score.state.timerDuration > 0 && value >= score.state.timerDuration) {
      value = score.state.timerDuration;
      running = false;
    }
    score.patch({ timerValue: value, timerRunning: running });
    registry.broadcast(score.name, { type: 'timer', value, running });
    if (!running) score.stopTimer();
  }, 1000);
}

// ---------------------------------------------------------------------
// Per-score commands. `this` is bound to { score, registry } by the caller.
// ---------------------------------------------------------------------
const SCORE_COMMANDS = {
  // Replies with `info` — an outlet line reporting the score's new page
  // (always 1), and — once the server is already running — its full
  // address, e.g. `violin address 192.168.1.5:8080/violin`. The page count
  // isn't included here: server.js reads it directly from the PDF file
  // right after this dispatches, and outlets it as soon as that resolves
  // (typically within a few ms) — see reportPageCount() there.
  load(score, registry, args) {
    // strip a wrapping quote pair, e.g. macOS "Copy as Pathname" on a path with spaces
    const quoted = args.join(' ').replace(/^(['"])(.*)\1$/, '$2');
    const filePath = stripVolumePrefix(quoted);
    if (!filePath) return { ok: false, error: 'load requires a file path' };
    const warning = path.isAbsolute(filePath)
      ? null
      : `load: '${filePath}' is not an absolute path — using it as-is, this will likely fail to resolve`;
    score.state.pdfPath = filePath; // never resolved/rewritten, used exactly as given
    score.state.pdfUrl = `/scores/${score.name}/score.pdf`;
    score.state.page = 1;
    score.state.pageCount = 0; // overwritten momentarily by server.js's reportPageCount()
    registry.broadcast(score.name, { type: 'load', url: score.state.pdfUrl });

    const result = { ok: true, info: [['currentPage', score.state.page]] };
    if (warning) result.warning = warning;
    const address = scoreAddress(registry, score.name);
    if (address) result.info.push(['address', address]);
    return result;
  },

  // Replies with `info` — an outlet line of ["currentPage", n] — reporting
  // the score's new current page, e.g. `violin currentPage 3`.
  page(score, registry, args) {
    const n = toInt(args[0], score.state.page);
    score.patch({ page: n });
    registry.broadcast(score.name, { type: 'page', page: n });
    return { ok: true, info: [['currentPage', n]] };
  },

  bar(score, registry, args) {
    const n = toInt(args[0], score.state.bar);
    score.patch({ bar: n });
    registry.broadcast(score.name, { type: 'position', bar: n, beat: score.state.beat });
    return { ok: true };
  },

  beat(score, registry, args) {
    const n = toInt(args[0], score.state.beat);
    score.patch({ beat: n });
    registry.broadcast(score.name, { type: 'position', bar: score.state.bar, beat: n });
    return { ok: true };
  },

  // Sets bar and beat together in one message/broadcast instead of two —
  // prefer this over separate `bar`/`beat` calls when driving continuous
  // playback position, to halve the WS traffic and client-side redraws.
  position(score, registry, args) {
    const bar = toInt(args[0], score.state.bar);
    const beat = toInt(args[1], score.state.beat);
    score.patch({ bar, beat });
    registry.broadcast(score.name, { type: 'position', bar, beat });
    return { ok: true };
  },

  barColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ barColor: hex });
    registry.broadcast(score.name, { type: 'barColor', color: hex });
    return { ok: true };
  },

  beatColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ beatColor: hex });
    registry.broadcast(score.name, { type: 'beatColor', color: hex });
    return { ok: true };
  },

  displayBar(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ displayBar: flag });
    registry.broadcast(score.name, { type: 'displayBar', flag });
    return { ok: true };
  },

  displayBeat(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ displayBeat: flag });
    registry.broadcast(score.name, { type: 'displayBeat', flag });
    return { ok: true };
  },

  textSize(score, registry, args) {
    const n = toInt(args[0], score.state.textSize);
    score.patch({ textSize: n });
    registry.broadcast(score.name, { type: 'textSize', size: n });
    return { ok: true };
  },

  text(score, registry, args) {
    const str = args.join(' ');
    score.patch({ text: str });
    registry.broadcast(score.name, { type: 'text', text: str });
    return { ok: true };
  },

  textColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ textColor: hex });
    registry.broadcast(score.name, { type: 'textColor', color: hex });
    return { ok: true };
  },

  black(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ black: flag });
    registry.broadcast(score.name, { type: 'black', flag });
    return { ok: true };
  },

  zoom(score, registry, args) {
    const z = toFloat(args[0], score.state.zoom);
    score.patch({ zoom: z });
    registry.broadcast(score.name, { type: 'zoom', zoom: z });
    return { ok: true };
  },

  flash(score, registry) {
    // one-shot, not persisted in state
    registry.broadcast(score.name, { type: 'flash', ms: score.state.flashDuration, color: score.state.flashColor });
    return { ok: true };
  },

  flashColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ flashColor: hex });
    return { ok: true }; // takes effect on the next `flash`, no need to push now
  },

  flashDuration(score, registry, args) {
    const n = toInt(args[0], score.state.flashDuration);
    score.patch({ flashDuration: n });
    return { ok: true }; // takes effect on the next `flash`, no need to push now
  },

  displayMetronome(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ displayMetronome: flag });
    registry.broadcast(score.name, { type: 'displayMetronome', flag });
    return { ok: true };
  },

  metronomeSize(score, registry, args) {
    const n = toFloat(args[0], score.state.metronomeSize);
    score.patch({ metronomeSize: n });
    registry.broadcast(score.name, { type: 'metronomeSize', size: n });
    return { ok: true };
  },

  metronomeColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ metronomeColor: hex });
    registry.broadcast(score.name, { type: 'metronomeColor', color: hex });
    return { ok: true };
  },

  metronomePosition(score, registry, args) {
    const x = toNormalized(args[0], score.state.metronomeX);
    const y = toNormalized(args[1], score.state.metronomeY);
    score.patch({ metronomeX: x, metronomeY: y });
    registry.broadcast(score.name, { type: 'metronomePosition', x, y });
    return { ok: true };
  },

  textPosition(score, registry, args) {
    const x = toNormalized(args[0], score.state.textX);
    const y = toNormalized(args[1], score.state.textY);
    score.patch({ textX: x, textY: y });
    registry.broadcast(score.name, { type: 'textPosition', x, y });
    return { ok: true };
  },

  barBeatPosition(score, registry, args) {
    const x = toNormalized(args[0], score.state.barBeatX);
    const y = toNormalized(args[1], score.state.barBeatY);
    score.patch({ barBeatX: x, barBeatY: y });
    registry.broadcast(score.name, { type: 'barBeatPosition', x, y });
    return { ok: true };
  },

  backgroundColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ backgroundColor: hex });
    registry.broadcast(score.name, { type: 'backgroundColor', color: hex });
    return { ok: true };
  },

  invertColor(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ invertColor: flag });
    registry.broadcast(score.name, { type: 'invertColor', flag });
    return { ok: true };
  },

  allowPageChange(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ allowPageChange: flag });
    registry.broadcast(score.name, { type: 'allowPageChange', flag });
    return { ok: true };
  },

  // Sent as `<scoreName> timer` (starts/restarts from 00:00, or from
  // timerDuration if timerDirection is -1), `<scoreName> timer <n>` (sets
  // timerDuration to n seconds, then starts the same way), or
  // `<scoreName> timer reset` (stops and resets to the same starting value,
  // without changing timerDuration/timerDirection).
  timer(score, registry, args) {
    const arg = args[0];
    const startValue = () => (score.state.timerDirection === -1 ? score.state.timerDuration : 0);

    if (arg === 'reset') {
      score.stopTimer();
      const value = startValue();
      score.patch({ timerValue: value, timerRunning: false });
      registry.broadcast(score.name, { type: 'timer', value, running: false });
      return { ok: true, info: [['timerValue', value]] };
    }

    if (arg !== undefined) {
      score.patch({ timerDuration: toInt(arg, score.state.timerDuration) });
    }
    const value = startValue();
    score.patch({ timerValue: value, timerRunning: true });
    registry.broadcast(score.name, { type: 'timer', value, running: true });
    startTimerTicking(score, registry);
    return { ok: true, info: [['timerValue', value]] };
  },

  timerDisplay(score, registry, args) {
    const flag = toFlag(args[0]);
    score.patch({ displayTimer: flag });
    registry.broadcast(score.name, { type: 'displayTimer', flag });
    return { ok: true };
  },

  timerSize(score, registry, args) {
    const n = toInt(args[0], score.state.timerSize);
    score.patch({ timerSize: n });
    registry.broadcast(score.name, { type: 'timerSize', size: n });
    return { ok: true };
  },

  timerColor(score, registry, args) {
    const hex = rgbIntToHex(args[0]);
    score.patch({ timerColor: hex });
    registry.broadcast(score.name, { type: 'timerColor', color: hex });
    return { ok: true };
  },

  // Sent as `<scoreName> timerDirection 1|-1`. Any nonnegative value counts
  // as 1 (count up), anything negative counts as -1 (count down) — same
  // liberal-parsing spirit as `black`.
  timerDirection(score, registry, args) {
    const d = toInt(args[0], score.state.timerDirection) < 0 ? -1 : 1;
    score.patch({ timerDirection: d });
    registry.broadcast(score.name, { type: 'timerDirection', direction: d });
    return { ok: true };
  },

  timerPosition(score, registry, args) {
    const x = toNormalized(args[0], score.state.timerX);
    const y = toNormalized(args[1], score.state.timerY);
    score.patch({ timerX: x, timerY: y });
    registry.broadcast(score.name, { type: 'timerPosition', x, y });
    return { ok: true };
  },

  getDeviceInfo(score, registry) {
    registry.broadcast(score.name, { type: 'getDeviceInfo', requestId: Date.now() });
    return { ok: true };
  },

  restart(score, registry) {
    score.reset();
    registry.broadcast(score.name, { type: 'sync', state: score.state, reload: true });
    return { ok: true, info: [['currentPage', score.state.page], ['pages', score.state.pageCount]] };
  },

  refresh(score, registry) {
    registry.broadcast(score.name, { type: 'reload' });
    return { ok: true };
  },
};

const COMMAND_ALIASES = { read: 'load' };

function dispatchScoreCommand(score, registry, command, args) {
  const handler = SCORE_COMMANDS[COMMAND_ALIASES[command] || command];
  if (!handler) return { ok: false, error: `unknown score command '${command}'` };
  return handler(score, registry, args);
}

module.exports = { makeGlobalCommands, dispatchScoreCommand, toFlag, toInt, toFloat, rgbIntToHex };
