# SyncSuite

Collection of Max for Live devices and Max objects for complex multimedia synchronization.

syncSuite is a **macOS-only** package (Max, Live, web browsers) that offers solutions for sound, video and score synchronization and manipulation in the context of multimedia performance. The package has a focus on live performance so that it is simple to design reliable and performant technical solutions that support the whole process of production, including composition, rehearsals and performance.

> **Platform:** syncSuite currently only supports macOS. The `jit.pdfmatrix` external is built for macOS only, and the package has not been tested on Windows.

## Repository contents

- **`max-package/`** — the Max package containing the underlying Max objects, patchers, JS scripts, externals (including `jit.pdfmatrix`), help files, and reference docs used by the M4L devices. Install the `syncSuite` folder inside it into your Max Packages folder to make the objects and abstractions available to Max and Live.
- **`m4l-devices/`** — the ready-to-use Max for Live devices (`.amxd`): `CueSync`, `LiveSync`, `OSCSync`, `ScoreSync` (part/server), `SubSync`, `VideoSync`, `VideoSyncOutput`. Drop these into an Ableton Live set to use SyncSuite directly.
- **`ableton-project/`** — an example/demo Ableton Live project (`syncSuite-help1.als`) showing the devices in use, along with supporting media (movies, subtitle styles, backups).

## Max objects

The Max package (`max-package/`) exposes the following objects/abstractions, each documented with its own help patcher and reference page:

| Object | Description |
| --- | --- |
| `syncSuite.scoreplayer` | Utility for designing, managing and triggering cues. |
| `syncSuite.score.server` | Node-for-Max server that streams a page-turning score to one or more remote devices. |
| `syncSuite.video.context` | Video rendering context. Wrapper around `jit.world` for easier and extended functionality. |
| `syncSuite.video.source` | Utility for rendering textures, matrices, playing video files and compositing controls. |
| `syncSuite.video.subs` | Utility for rendering text in the SyncSuite video context. |
| `syncSuite.netscan` | Reports your machine's own IP/mask and discovers live devices on a subnet via a ping sweep. |
| `jit.pdfmatrix` | Renders a page of a PDF file into a Jitter matrix (macOS-only external). |

## M4L devices

The ready-to-use Max for Live devices in `m4l-devices/`:

| Device | Description |
| --- | --- |
| `CueSync.amxd` | Triggers and synchronizes cues within a Live set. |
| `LiveSync.amxd` | Synchronizes SyncSuite devices with Ableton Live's transport/session state. |
| `OSCSync.amxd` | Sends/receives OSC messages to synchronize with external devices and software. |
| `ScoreSync.server.amxd` | Server device that streams a page-turning score to remote `ScoreSync.part` devices. |
| `ScoreSync.part.amxd` | Client device that receives and displays the page-turning score from `ScoreSync.server`. |
| `SubSync.amxd` | Displays synchronized subtitles/captions during playback. |
| `VideoSync.amxd` | Plays and synchronizes video within a Live set. |
| `VideoSyncOutput.amxd` | Controls the video output window (enable, fullscreen, position, fps). |

## Installation

There are two ways to get SyncSuite:

- **Release zip (recommended).** Download `SyncSuite-v<version>.zip` from the [releases page](https://github.com/agustinissidoro/SyncSuite/releases) and skip to step 2. In the zip, the Ableton project carries its own copy of the devices, so `ableton-project/` and `m4l-devices/` can each be placed wherever you like.
- **Cloning the repository.** Meant for development. Here the Live Sets use the devices in `m4l-devices/syncSuite/` directly, so `ableton-project/` and `m4l-devices/` have to stay next to each other, as they are in the repository. If you move one of them, Live will report the devices as missing and you will have to locate them by hand.

### 1. Git LFS (only when cloning)

This repository uses [Git LFS](https://git-lfs.com) to store large media files (e.g. files under `ableton-project/movies/`). Install Git LFS before cloning so those files download correctly instead of being checked out as small pointer files:

```bash
# install Git LFS (once per machine)
brew install git-lfs   # macOS, or see git-lfs.com for other platforms
git lfs install
```

Then clone the repository normally — LFS-tracked files are fetched automatically:

```bash
git clone https://github.com/agustinissidoro/SyncSuite.git
cd syncSuite
```

If you already cloned the repo before installing Git LFS, run:

```bash
git lfs pull
```

### 2. Max package

Copy the `max-package/syncSuite/` folder into your Max Packages directory (macOS):

- `~/Documents/Max 9/Packages/`

Restart Max (or Ableton Live) afterwards so the package is indexed.

### 3. M4L devices

Once the Max package is installed, open the devices in `m4l-devices/` from Ableton Live's browser, or drag the individual `.amxd` files from that folder directly onto a track.

### 4. Ableton project

Open `ableton-project/syncSuite-help1.als` in Ableton Live to see a working example of the devices set up together, including sample video/subtitle assets.

The devices in these sets still need the Max package from step 2. If you cloned the repository, keep `ableton-project/` next to `m4l-devices/` (see the note at the top of this section).

## Release notes

### v0.0.3

- The Max for Live devices are now frozen (all except `ScoreSync.server`), so they carry what they need and work in Live without the Max package. `ScoreSync.server` still needs the syncSuite Max package; its INFO window and the one of `ScoreSync.part` now say so. An unused leftover subpatcher was removed from it, so it no longer asks for the odot package.
- The automatable parameters of `LiveSync`, `OSCSync`, `ScoreSync.part`, `ScoreSync.server` and `VideoSyncOutput` have proper names (`send_tempo`, `page`, `source1_scale`…) instead of `live.toggle[3]`. Live Sets saved with an earlier version will load these parameters at their default values.
- `VideoSync`: with an unsaved Live Set the device no longer loads a file list from somewhere else on the computer.
- `syncSuite.video.source`: the crop shader is now part of the patcher. It was a separate file that was missing from the package.
- Example project: the release zip carries its own copy of the devices, so `ableton-project/` opens from any location; added `syncSuite-help2.als`; removed four unused audio files.
- Score server dependencies updated (express 5.3.0, ws 8.22.0).
- Installation instructions explain the difference between the release zip and cloning the repository.

### v0.0.2

- New visual style (HOOU design) for all Max for Live devices, their INFO windows, the help patchers, the tutorials, the Overview patcher and the PDF documentation; the package now has its own icon.
- `syncSuite.netscan`: `scan` is more reliable. It sweeps the subnet twice and also reads the system's ARP table, so devices that answer late or do not answer ping at all are no longer missed. Invalid addresses or masks are rejected with a message, and overlapping scans are queued.
- Fixed `CueSync.amxd`.
- Reorganized the repository: the Max package now lives in `max-package/syncSuite/` and the devices in `m4l-devices/syncSuite/`.
- Package version set to 0.0.2 and the unsupported Windows entry removed from `package-info.json`.
- Corrected installation instructions.
- Added `VideoSyncOutput` and `syncSuite.netscan` to the documentation.

### v0.0.1 (tag `v.0.0.1`)

First public release of SyncSuite.

- **Max for Live devices:** `CueSync`, `LiveSync`, `OSCSync`, `ScoreSync.server`, `ScoreSync.part`, `SubSync`, `VideoSync`, `VideoSyncOutput`.
- **Max package:** `syncSuite.scoreplayer`, `syncSuite.score.server`, `syncSuite.video.context`, `syncSuite.video.source`, `syncSuite.video.subs`, `syncSuite.netscan` and the `jit.pdfmatrix` external, each with a help patcher and reference page.
- **Example project:** Ableton Live project with help and tutorial sets (CueSync, OSCSync, score, video), including sample videos and subtitle styles.
- **Documentation:** `syncSuite_doc.pdf`.

Known limitations:

- macOS only; not tested on Windows.
- Requires Max 9.

## Credits

By Agustín Issidoro, Hamburg, 2026.

The syncSuite project was made possible thanks to the support of the **Hamburg Open Online University (HOOU)** and the **Hochschule für Musik und Theater Hamburg (HfMT Hamburg)**.
