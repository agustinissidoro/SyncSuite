# SyncSuite

Collection of Max for Live devices and Max objects for complex multimedia synchronization.

syncSuite is a **macOS-only** package (Max, Live, web browsers) that offers solutions for sound, video and score synchronization and manipulation in the context of multimedia performance. The package has a focus on live performance so that it is simple to design reliable and performant technical solutions that support the whole process of production, including composition, rehearsals and performance.

> **Platform:** syncSuite currently only supports macOS. The `jit.pdfmatrix` external is built for macOS only, and the package has not been tested on Windows.

## Repository contents

- **`max-package/`** — the Max package containing the underlying Max objects, patchers, JS scripts, externals (including `jit.pdfmatrix`), help files, and reference docs used by the M4L devices. Install this into your Max Packages folder to make the objects and abstractions available to Max and Live.
- **`m4l-devices/`** — the ready-to-use Max for Live devices (`.amxd`): `CueSync`, `LiveSync`, `OSCSync`, `ScoreSync` (part/server), `SubSync`, `VideoSync`. Drop these into an Ableton Live set to use SyncSuite directly.
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

## Installation

### 1. Git LFS

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

Copy (or symlink) the `max-package/` folder into your Max Packages directory (macOS) so its contents are picked up as a package named `syncSuite`:

- `~/Documents/Max 9/Packages/`

Restart Max (or Ableton Live) afterwards so the package is indexed.

### 3. M4L devices

Once the Max package is installed, open the devices in `m4l-devices/` from Ableton Live's browser, or drag the individual `.amxd` files from that folder directly onto a track.

### 4. Ableton project

Open `ableton-project/syncSuite-help1.als` in Ableton Live to see a working example of the devices set up together, including sample video/subtitle assets.

## Credits

By Agustín Issidoro, Hamburg, 2026.

The syncSuite project was made possible thanks to the support of the **Hamburg Open Online University (HOOU)** and the **Hochschule für Musik und Theater Hamburg (HfMT Hamburg)**.
