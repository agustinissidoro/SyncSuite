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
   1060,
   780
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
      600,
      24
     ],
     "text": "mc.syncSuite.leveller~",
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
     "text": "A slow loudness leveller for speaker layouts: one gain for every channel (the image never changes), towards a BS.1770 target, at most up / down dB per second, holding below the gate. The display: the last minute of input (dim) and output (pink) loudness, the target (cyan), the gain underneath.",
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
      88,
      500,
      20
     ],
     "text": "a source whose level wanders between -45 and -10 dB (8 channels)",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      112,
      125,
      22
     ],
     "text": "mc.pink~ @chans 8",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      160,
      112,
      90,
      22
     ],
     "text": "cycle~ 0.03",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "newobj",
     "numinlets": 6,
     "numoutlets": 1,
     "patching_rect": [
      160,
      142,
      150,
      22
     ],
     "text": "scale~ -1. 1. -45. -10.",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      160,
      172,
      60,
      22
     ],
     "text": "dbtoa~",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      204,
      66,
      22
     ],
     "text": "mc.*~",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      236,
      60,
      20
     ],
     "text": "layout",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      236,
      395,
      22
     ],
     "text": "speaker_coords -22.5 22.5 67.5 112.5 157.5 -157.5 -112.5 -67.5, lfe",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      262,
      330,
      22
     ],
     "text": "speaker_coords 30 -30 0 0 110 -110 150 -150, lfe 4",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      480,
      236,
      500,
      20
     ],
     "text": "octagon (syncSuite.nodes' default ring)"
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      420,
      262,
      560,
      20
     ],
     "text": "7.1: L R C LFE Ls Rs Lb Rb"
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "mc.syncSuite.leveller~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      20,
      380,
      980,
      190
     ],
     "outlettype": [
      "multichannelsignal",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      292,
      60,
      20
     ],
     "text": "targets",
     "fontface": 1
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
      292,
      70,
      22
     ],
     "text": "target -23",
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
      156,
      292,
      70,
      22
     ],
     "text": "target -16",
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
      232,
      292,
      40,
      22
     ],
     "text": "reset",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      280,
      292,
      520,
      20
     ],
     "text": "EBU R128 / streaming; reset: gain back to 0 dB"
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "target",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "window",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "up",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "down",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      680,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "max_boost",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      318,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "max_cut",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "gate",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "tolerance",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "freeze",
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
      515,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "loudness_weights",
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
      680,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "view",
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
      845,
      344,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "bypass_ui",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      580,
      30,
      22
     ],
     "text": "get",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-33",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      60,
      580,
      110,
      22
     ],
     "text": "print leveller"
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      620,
      190,
      22
     ],
     "text": "mc.syncSuite.virtualspeakers~",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      650,
      66,
      22
     ],
     "text": "mc.*~ 0.5",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      680,
      84,
      22
     ],
     "text": "mc.dac~ 1 2"
    }
   },
   {
    "box": {
     "id": "obj-37",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      215,
      620,
      380,
      20
     ],
     "text": "listen on headphones (same layout messages)"
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "ezdac~",
     "numinlets": 2,
     "numoutlets": 0,
     "patching_rect": [
      120,
      670,
      45,
      45
     ]
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      560,
      580,
      440,
      34
     ],
     "text": "No display, a standard object: type @no_ui 1 with the object.",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "mc.syncSuite.leveller~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      560,
      618,
      219.70000000000002,
      22
     ],
     "outlettype": [
      "multichannelsignal",
      ""
     ],
     "no_ui": 1
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      710,
      980,
      48
     ],
     "text": "Outlet 2 (get, or every frame with @output 1): loudness <in M> <in S> <out M> <out S> (LUFS), gain <applied> <desired> (dB), gated <0|1>. No latency, no compression: a slow fader. Put mc.syncSuite.limiter~ after it for a safe output.",
     "linecount": 3
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-5",
      0
     ],
     "destination": [
      "obj-6",
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
      "obj-4",
      0
     ],
     "destination": [
      "obj-8",
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
      "obj-8",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-8",
      0
     ],
     "destination": [
      "obj-14",
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
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
      0
     ],
     "destination": [
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-22",
      0
     ],
     "destination": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-23",
      0
     ],
     "destination": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-24",
      0
     ],
     "destination": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25",
      0
     ],
     "destination": [
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
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
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-14",
      1
     ],
     "destination": [
      "obj-33",
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
      "obj-34",
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
      "obj-35",
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
      "obj-36",
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
      "obj-34",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
      0
     ],
     "destination": [
      "obj-34",
      0
     ]
    }
   }
  ]
 }
}