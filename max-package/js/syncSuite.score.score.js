/**
 * score.js
 *
 * Owns all server-side state. One Score per instrument. The browser is a
 * dumb renderer of this state — every command mutates a Score object here
 * first, then broadcasts only the delta to that score's connected clients.
 * A client that reconnects can request a full sync and get everything
 * back in one message.
 */

function defaultState() {
  return {
    pdfPath: null,
    pdfUrl: null,      // public URL the browser fetches, e.g. /scores/violin/score.pdf
    page: 1,
    pageCount: 0,
    zoom: 1.0,
    displayBar: false,
    displayBeat: false,
    bar: 0,
    beat: 0,
    barColor: '#00ff00',
    beatColor: '#00ff00',
    textSize: 24,
    text: '',
    textColor: '#ffffff',
    black: false,
    flashColor: '#ff0000',
    flashDuration: 50, // ms
    displayMetronome: false,
    metronomeSize: 1.0,
    metronomeColor: '#333333',
    allowPageChange: true,
    backgroundColor: '#111111',
    invertColor: false,
    textX: 0.5, textY: 0.92,         // normalized (0.-1.) position of the text overlay's center
    barBeatX: 0.1, barBeatY: 0.06,   // normalized (0.-1.) position of the bar/beat overlay's center
    metronomeX: 0.92, metronomeY: 0.08, // normalized (0.-1.) position of the metronome's center
    displayTimer: false,
    timerRunning: false,
    timerValue: 0,      // seconds currently shown, mm:ss on the client
    timerDuration: 0,   // seconds set by "timer <n>"; 0 = unbounded count-up
    timerDirection: 1,  // 1 counts up, -1 counts down
    timerSize: 48,
    timerColor: '#ffffff',
    timerX: 0.5, timerY: 0.08, // normalized (0.-1.) position of the timer overlay's center
  };
}

class Score {
  constructor(name) {
    this.name = name;
    this.state = defaultState();
    this.clients = new Set(); // WebSocket connections currently on /<name>
    this.timerHandle = null;  // setInterval handle driving the running timer's ticks, see commands.js
  }

  /** Merge a partial state update and return just the changed keys. */
  patch(update) {
    Object.assign(this.state, update);
    return update;
  }

  stopTimer() {
    if (this.timerHandle) {
      clearInterval(this.timerHandle);
      this.timerHandle = null;
    }
  }

  reset() {
    this.stopTimer();
    this.state = defaultState();
  }
}

class ScoreRegistry {
  constructor({ onBroadcast }) {
    this.scores = new Map(); // name -> Score
    this.onBroadcast = onBroadcast; // (scoreName, message) => void, wired up by server.js
    this.serverAddress = null; // "<ip>:<port>", set by server.js once listening
  }

  setAddress(address) {
    this.serverAddress = address;
  }

  has(name) {
    return this.scores.has(name);
  }

  get(name) {
    return this.scores.get(name);
  }

  all() {
    return [...this.scores.values()];
  }

  addScore(name) {
    if (this.scores.has(name)) return { ok: false, error: `score '${name}' already exists` };
    this.scores.set(name, new Score(name));
    return { ok: true };
  }

  deleteScore(name) {
    const score = this.scores.get(name);
    if (!score) return { ok: false, error: `score '${name}' does not exist` };
    score.stopTimer();
    this.broadcast(name, { type: 'removed' });
    score.clients.forEach(ws => ws.close());
    this.scores.delete(name);
    return { ok: true };
  }

  broadcast(name, message) {
    this.onBroadcast(name, message);
  }
}

module.exports = { Score, ScoreRegistry, defaultState };
