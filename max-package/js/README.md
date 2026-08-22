# syncSuite.score — server

A Node for Max server that drives a PDF score viewer on any number of
networked devices (tablets/phones/browsers), one "score" (instrument) per
device or group of devices. Max is the source of truth: every command
mutates server-side state (`syncSuite.score.score.js`) and broadcasts the
delta over WebSocket to that score's connected viewers
(`html/syncSuite.score.viewer.html`).

All state lives in memory only — nothing is written to or read from disk
(PDFs are served straight from the absolute path you give `load`, never
copied). Restarting the server (or the process being auto-reloaded by
`@watch`) wipes every registered score; re-declare and re-load them from
Max on each run, same as at first launch.

## Setup

```
cd js
npm install
```

In Max, a `node.script` object pointed at `syncSuite.score.server.js` runs
the server. It accepts an optional port argument in the object box:

```
node.script syncSuite.score.server.js 9090
```

(falls back to the `PORT` env var, then `8080`).

On startup it outlets `ip <address>:<port>` and `serverState 1` — that's
the address other devices should open in a browser, e.g.
`http://192.168.1.23:8080/violin`.

You can also install dependencies from inside Max by sending
`npm install express ws pdf-lib` to the `node.script` object.

## Message format

**Global commands** — sent as-is:

```
addScore <name>
deleteScore <name>
restart
refresh
```

**Per-score commands** — sent as `<scoreName> <command> ...args`:

```
violin page 3
violin bar 12
```

**Fan-out to every score** — use `all` in place of a score name:

```
all page 1
all invertColor 1
```

## Commands

### Global

| Command | Args | Effect |
|---|---|---|
| `addScore` | `<name>` | Registers a new score and starts listening for `<name> ...` commands. Also outlets `<name> connectedDevices 0`, `<name> state 0`, `<name> currentPage 1`, `<name> pages 0`, and — if the server is already running — `<name> address <fullAddress>`. |
| `deleteScore` | `<name>` | Removes a score, closes its viewers' connections. |
| `get` | `<name>` | Reports that score's address, loaded file and connected devices — see below. Fails if the server isn't running or `<name>` isn't registered. |
| `restart` | — | Resets every score to default state and reloads all connected viewer pages. |
| `refresh` | — | Reloads all connected viewer pages (no state reset). |

### Per-score (`<scoreName> <command> ...args`, or `all <command> ...args`)

| Command | Args | Effect |
|---|---|---|
| `load` / `read` | `<path>` | Loads a PDF score. Path is used as-is (not resolved); a warning is outletted if it's not absolute. Handles macOS "Copy as Pathname" (quoted, space-containing) paths, and strips a leading boot-volume prefix (e.g. `Macintosh HD:/Users/...` → `/Users/...`). Resets to page 1, outletting `<scoreName> currentPage 1` immediately, followed moments later by `<scoreName> pages <n>` — the server reads the real page count directly from the PDF file, no device needs to be connected. Also outlets `<scoreName> address <fullAddress>` if the server is already running. |
| `page` | `<n>` | Jumps to page `n`, outletting `<scoreName> currentPage <n>`. |
| `bar` | `<n>` | Sets the current bar number (display only, for the bar/beat overlay). |
| `beat` | `<n>` | Sets the current beat number, and the number shown inside the metronome circle. |
| `position` | `<bar> <beat>` | Sets bar and beat together in one message — prefer this over separate `bar`/`beat` calls when driving continuous playback position, to halve the traffic/redraws. |
| `displayBar` | `<flag>` | Shows/hides the bar number in the overlay. |
| `displayBeat` | `<flag>` | Shows/hides the beat number in the overlay. |
| `barColor` | `<rgb-int>` | Sets the "Bar `<n>`" text color. Default green. |
| `beatColor` | `<rgb-int>` | Sets the "Beat `<n>`" text color. Default green. |
| `textSize` | `<n>` | Font size (px) of the text overlay. |
| `text` | `<string...>` | Sets/shows the text overlay (empty string hides it). |
| `textColor` | `<rgb-int>` | Sets the text overlay's color. Default white. |
| `textPosition` | `<x> <y>` | Position (normalized float, 0.–1.) of the text overlay's center. |
| `barBeatPosition` | `<x> <y>` | Position (normalized float, 0.–1.) of the bar/beat overlay's center. |
| `black` | `<flag>` | Shows/hides a full black screen over the score. Any nonzero value counts as on, e.g. `black 2`. |
| `zoom` | `<factor>` | Scales the page (1.0 = 100%). |
| `backgroundColor` | `<rgb-int>` | Sets the viewer's background color (Max color atom). |
| `invertColor` | `<flag>` | Inverts the score's colors (white-paper scores → dark, low-luminosity). Overlays are unaffected. |
| `flash` | — | One-shot full-screen color flash, using the current `flashColor` and `flashDuration`. |
| `flashColor` | `<rgb-int>` | Sets the color used by the next `flash`. |
| `flashDuration` | `<ms>` | Sets how long, in milliseconds, the next `flash` stays visible. Default 50. |
| `displayMetronome` | `<flag>` | Shows/hides the metronome circle. It flashes white on every beat, showing the current beat number inside it. |
| `metronomeSize` | `<factor>` | Scales the metronome circle (1.0 = 26px). |
| `metronomeColor` | `<rgb-int>` | Sets the metronome circle's idle (between-beats) color. Default dark gray; always flashes white on the beat. |
| `metronomePosition` | `<x> <y>` | Position (normalized float, 0.–1.) of the metronome circle's center. Default near the top-right corner. |
| `allowPageChange` | `<flag>` | Allows/blocks devices from turning their own pages via swipe. A device's own page turns are also always bounded by `<scoreName> pages <n>` (see below), sent moments after `load`/`read` resolves it from the PDF file, so they have no effect in the brief window before that arrives. |
| `getDeviceInfo` | — | Asks connected viewers to report device info (see below). |
| `restart` | — | Resets this score to default state and reloads its viewers, outletting `<scoreName> currentPage 1` and `<scoreName> pages 0`. |
| `refresh` | — | Reloads this score's viewers (no state reset). |

`<flag>` accepts `0`/`1`/`true`/`false`, or in fact any nonzero value (e.g. `black 2` also turns it on).

## Outlet messages (Max console / patch)

| Message | Meaning |
|---|---|
| `ip <address>:<port>` | Sent once on startup — the URL prefix devices should connect to. |
| `serverState 1` / `serverState 0` | `1` once the HTTP server is listening; `0` if it fails to start or hits a fatal error (also sends an `error`). |
| `<scoreName> connectedDevices <n>` | Live count of open viewer connections for that score. Fires on every device connect/disconnect, and once (`0`) right after `addScore`. |
| `<scoreName> state 1` / `<scoreName> state 0` | `1` if at least one device is connected for that score, `0` if none. Fires alongside `connectedDevices`. |
| `<scoreName> address <fullAddress>` | Sent after `addScore` or `load`/`read`, once the server is already running — e.g. `violin address 192.168.1.5:8080/violin`. |
| `deviceEvent <scoreName> connect` / `disconnect` | A device's WebSocket connected/disconnected. |
| `deviceInfo <scoreName> push\|response <screenWidth> <screenHeight> <devicePixelRatio> <fullscreen>` | Device info. `push` = sent unprompted (on connect, or on fullscreen change); `response` = answering a `getDeviceInfo` command. |
| `<scoreName> currentPage <n>` | The current page, whenever it changes — from `addScore`, `page`, `load`/`read`, `restart`, or a device turning its own page via swipe (only when `allowPageChange` is on). |
| `<scoreName> pages <n>` | The total page count of the loaded PDF. Sent as `0` right after `addScore` or `restart`; sent with the real count moments after `load`/`read`, read directly from the PDF file (no device needs to be connected); sent again whenever any connected device separately reports its own rendered count back. |
| `error <message>` | A command failed. |
| `warning <message>` | A command succeeded with a caveat (e.g. non-absolute `load` path). |
| `<scoreName> ip <address>:<port>/<scoreName>` | Reply to `get` — the full URL path devices should open to view this score. |
| `<scoreName> file <absolute-path>` | Reply to `get` — the currently loaded PDF's path (empty string if none loaded). |
| `<scoreName> currentPage <n>` | Reply to `get` — the current page. |
| `<scoreName> pages <n>` | Reply to `get` — the total page count of the loaded PDF (0 if none loaded). |
| `<scoreName> connectedDevices <device-ip> 1` | Reply to `get` — one message per device currently connected to this score, giving that device's IP. |

## Client-side behavior (viewer)

- Requires a user tap ("Tap to begin") to enter fullscreen and open the
  WebSocket — browsers only allow `requestFullscreen()` inside a user
  gesture. If fullscreen is exited later (e.g. by the OS chrome on a
  tablet), a small "Fullscreen" button reappears to re-enter it, and a
  double-tap anywhere on the screen does the same thing. Works around
  iPad/tablet Safari needing the `webkit`-prefixed fullscreen API.
- Horizontal swipe turns pages (if `allowPageChange` is on) by asking the
  server to advance/retreat the page — the server is the authority and
  broadcasts the resulting page to every viewer of that score.
- PDF rendering (`pdf.js`) is vendored locally under `html/vendor/pdfjs/`
  and served by this server — no internet connection required. The canvas
  stays hidden until the first page actually finishes rendering, avoiding
  a black flash between the fullscreen tap and the score appearing.

## Performance notes

- Prefer `position <bar> <beat>` over separate `bar`/`beat` calls when
  driving continuous playback position — it's one WS message/redraw
  instead of two.
- The viewer only touches the DOM properties that actually changed on each
  incoming message (diffed against its previous state), instead of
  rewriting every overlay's style on every message — this matters most
  when position/text/etc. update frequently.
- After loading a score, remaining pages are pre-rendered outward from the
  current page (n, n±1, n±2, ...) rather than strictly front-to-back, so
  an early page turn is far more likely to already be cached.
