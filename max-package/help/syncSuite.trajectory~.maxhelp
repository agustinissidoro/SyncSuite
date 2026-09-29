{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 0,
   "revision": 0,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   60,
   60,
   1030,
   910
  ],
  "gridsize": [
   15,
   15
  ],
  "boxes": [
   {
    "box": {
     "id": "obj-1",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      8,
      500,
      24
     ],
     "text": "syncSuite.trajectory~",
     "fontsize": 16.0,
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      32,
      1000,
      48
     ],
     "text": "Movement of one source, designed on musical time. In: the transport position in beats (signal, or float / position messages). Out: azimuth, distance, elevation as signals (e.g. to live.remote~ on MultipanSync's s<n>_az / s<n>_d) and messages (source <n> az dist for syncSuite.nodes). The position is a pure function of the beat: jumping, looping, scrubbing always agree. One object per source.",
     "linecount": 3
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      90,
      250,
      20
     ],
     "text": "transport (you provide it): signal ramp in beats",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      114,
      110,
      22
     ],
     "text": "0, 64 32000",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      136,
      114,
      110,
      22
     ],
     "text": "0, 64 16000",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      252,
      114,
      50,
      22
     ],
     "text": "stop",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "patching_rect": [
      20,
      146,
      60,
      22
     ],
     "text": "line~",
     "outlettype": [
      "signal",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      90,
      146,
      300,
      20
     ],
     "text": "64 beats at 120 / 240 BPM (a transport ramp)"
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      420,
      90,
      300,
      20
     ],
     "text": "or control rate: beats as a float",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "flonum",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      420,
      114,
      60,
      22
     ],
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0,
     "format": 6
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      486,
      114,
      300,
      20
     ],
     "text": "(drag it: scrubbing gives the same positions as playing)"
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      180,
      60,
      20
     ],
     "text": "shape",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      180,
      470,
      22
     ],
     "text": "shape orbit, period 8, quantize 0, turns 1",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      205,
      470,
      22
     ],
     "text": "shape orbit, period 8, quantize 0.5, glide 0.6",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      230,
      470,
      22
     ],
     "text": "shape pendulum, period 4, width 150",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      255,
      470,
      22
     ],
     "text": "shape spiral, period 16, turns 3, distance 1, distance_end 0.1, loop pingpong",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      280,
      470,
      22
     ],
     "text": "shape lissajous, period 8, lissajous 3 2, distance 0.9",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      305,
      470,
      22
     ],
     "text": "shape path, period 8, loop loop, path -30 1 0 30 1 0 100 0.3 0 180 0.9 0 -100 0.5 0",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      330,
      470,
      22
     ],
     "text": "shape steps, step 0.5, order random, glide 0.4, path",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      355,
      470,
      22
     ],
     "text": "shape steps, step 0.25, order pingpong, glide 0.8, arc 0, path",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      380,
      470,
      22
     ],
     "text": "shape wander, step 1, azimuth 0, range 120 0.35 0, distance 0.65",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560,
      180,
      420,
      20
     ],
     "text": "orbit: 8 beats per turn; then moving on eighths, gliding 60 % of each"
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560,
      330,
      420,
      20
     ],
     "text": "path: click to add points, drag them, alt-click to delete (clear_path)"
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560,
      355,
      420,
      20
     ],
     "text": "steps: no path = hop between the speakers (speaker_coords)"
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560,
      380,
      420,
      20
     ],
     "text": "random = a new shuffle of all targets every round, never twice in a row"
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      410,
      395,
      22
     ],
     "text": "speaker_coords -22.5 22.5 67.5 112.5 157.5 -157.5 -112.5 -67.5",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      480,
      410,
      70,
      22
     ],
     "text": "clear_path",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "shape",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-29",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "period",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "offset",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "loop",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      680,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "quantize",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-33",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      442,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "glide",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "step",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "order",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "rotate",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-37",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "scale",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      680,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "mirror",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      468,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "source",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "syncSuite.trajectory~",
     "numinlets": 1,
     "numoutlets": 4,
     "patching_rect": [
      20,
      576,
      240,
      240
     ],
     "outlettype": [
      "signal",
      "signal",
      "signal",
      ""
     ],
     "speaker_coords": [
      -22.5,
      22.5,
      67.5,
      112.5,
      157.5,
      -157.5,
      -112.5,
      -67.5
     ],
     "period": 8.0
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      280,
      576,
      80,
      22
     ],
     "text": "snapshot~ 50",
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-42",
     "maxclass": "flonum",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      280,
      604,
      70,
      22
     ],
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-43",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      356,
      604,
      80,
      20
     ],
     "text": "azimuth"
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      280,
      636,
      80,
      22
     ],
     "text": "snapshot~ 50",
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-45",
     "maxclass": "flonum",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      280,
      664,
      70,
      22
     ],
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      356,
      664,
      80,
      20
     ],
     "text": "distance"
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      280,
      696,
      80,
      22
     ],
     "text": "snapshot~ 50",
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "flonum",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      280,
      724,
      70,
      22
     ],
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      356,
      724,
      80,
      20
     ],
     "text": "elevation"
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      460,
      576,
      100,
      22
     ],
     "text": "print trajectory"
    }
   },
   {
    "box": {
     "id": "obj-51",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "patching_rect": [
      460,
      606,
      110,
      22
     ],
     "text": "route source",
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      460,
      636,
      70,
      22
     ],
     "text": "prepend set",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-53",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      460,
      666,
      200,
      22
     ],
     "text": "",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-54",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      460,
      692,
      520,
      48
     ],
     "text": "Messages: position az dist el, xyz x y z, and with @source n: source n az dist (straight into syncSuite.nodes). With a signal in they come at the display rate only with @output 1; with floats in, on every float.",
     "linecount": 3
    }
   },
   {
    "box": {
     "id": "obj-55",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      830,
      980,
      62
     ],
     "text": "In a Live device (one per source): your transport position in beats -> this object; its azimuth / distance signals -> live.remote~ mapped to MultipanSync's s<n>_az and s<n>_d (ranges -180..180 and 0..1, the same as these outputs). live.remote~ writes no automation and no undo steps. Elevation is ready for 3D layouts (syncSuite.nodes is 2D today).",
     "linecount": 3
    }
   },
   {
    "box": {
     "maxclass": "attrui",
     "attr": "bypass_ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20,
      512,
      160,
      22
     ],
     "parameter_enable": 0,
     "id": "obj-56"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "text": "bypass_ui: stop drawing (the audio / measurement goes on)",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      186,
      512,
      330,
      20
     ],
     "id": "obj-57"
    }
   },
   {
    "box": {
     "maxclass": "comment",
     "text": "@no_ui 1 (type it with the object): a standard object box, no display, no timer ->",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      542,
      470,
      20
     ],
     "id": "obj-58"
    }
   },
   {
    "box": {
     "maxclass": "syncSuite.trajectory~",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "signal",
      "signal",
      "signal",
      ""
     ],
     "patching_rect": [
      500,
      540,
      213.0,
      22
     ],
     "no_ui": 1,
     "id": "obj-59"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-4",
      0
     ],
     "destination": [
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-5",
      0
     ],
     "destination": [
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-7",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-10",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-13",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-14",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-15",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-16",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-17",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-18",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-21",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-26",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-27",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-28",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-31",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-32",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-33",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-34",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-35",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-36",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-38",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-39",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      0
     ],
     "destination": [
      "obj-41",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-41",
      0
     ],
     "destination": [
      "obj-42",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      1
     ],
     "destination": [
      "obj-44",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-44",
      0
     ],
     "destination": [
      "obj-45",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      2
     ],
     "destination": [
      "obj-47",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-47",
      0
     ],
     "destination": [
      "obj-48",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      3
     ],
     "destination": [
      "obj-50",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      3
     ],
     "destination": [
      "obj-51",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-51",
      0
     ],
     "destination": [
      "obj-52",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-52",
      0
     ],
     "destination": [
      "obj-53",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-56",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   }
  ]
 }
}