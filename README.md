# SyncSuite

Collection of Max for Live devices and Max objects for complex multimedia synchronization.

syncSuite is a cross-platform package (Max, Live, web browsers) that offers solutions for sound, video and score synchronization and manipulation in the context of multimedia performance. The package has a focus on live performance so that it is simple to design reliable and performant technical solutions that support the whole process of production, including composition, rehearsals and performance.

## Repository contents

- **`max-package/`** — the Max package containing the underlying Max objects, patchers, JS scripts, externals (including `jit.pdfmatrix`), help files, and reference docs used by the M4L devices. Install this into your Max Packages folder to make the objects and abstractions available to Max and Live.
- **`m4l-devices/`** — the ready-to-use Max for Live devices (`.amxd`): `CueSync`, `LiveSync`, `OSCSync`, `ScoreSync` (part/server), `SubSync`, `VideoSync`. Drop these into an Ableton Live set to use SyncSuite directly.
- **`ableton-project/`** — an example/demo Ableton Live project (`syncSuite-help1.als`) showing the devices in use, along with supporting media (movies, subtitle styles, backups).

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

Copy (or symlink) the `max-package/` folder into your Max Packages directory so its contents are picked up as a package named `syncSuite`:

- macOS: `~/Documents/Max 9/Packages/`
- Windows: `Documents\Max 9\Packages\`

Restart Max (or Ableton Live) afterwards so the package is indexed.

### 3. M4L devices

Once the Max package is installed, open the devices in `m4l-devices/` from Ableton Live's browser, or drag the individual `.amxd` files from that folder directly onto a track.

### 4. Ableton project

Open `ableton-project/syncSuite-help1.als` in Ableton Live to see a working example of the devices set up together, including sample video/subtitle assets.

## Credits

By Agustín Issidoro, Hamburg, 2026.

The syncSuite project was made possible thanks to the support of the **Hamburg Open Online University (HOOU)** and the **Hochschule für Musik und Theater Hamburg (HfMT Hamburg)**.
