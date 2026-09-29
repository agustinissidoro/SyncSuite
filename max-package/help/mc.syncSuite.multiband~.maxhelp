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
   924
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
     "text": "mc.syncSuite.multiband~",
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
     "text": "Multiband compressor for speaker layouts: up to 6 phase-aligned Linkwitz-Riley bands (they sum flat, with the same phase rotation on every channel). Per-band lists: threshold, ratio, knee, attack, release, makeup, range. Linking per band within groups. One multichannel inlet and outlet, channel i = speaker i.",
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
      200,
      20
     ],
     "text": "test sources (8 channels)",
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
      20,
      176,
      66,
      22
     ],
     "text": "mc.*~ 0.",
     "outlettype": [
      "multichannelsignal"
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
      20,
      146,
      30,
      22
     ],
     "text": "0.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      50,
      146,
      30,
      22
     ],
     "text": "0.3",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      86,
      146,
      30,
      22
     ],
     "text": "1.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      118,
      146,
      30,
      22
     ],
     "text": "2.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      150,
      112,
      120,
      20
     ],
     "text": "pink noise, all"
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      290,
      112,
      410,
      22
     ],
     "text": "mc.cycle~ @chans 8 @values 55 110 220 440 880 1760 3520 7040",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      290,
      176,
      66,
      22
     ],
     "text": "mc.*~ 0.",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      290,
      146,
      30,
      22
     ],
     "text": "0.",
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
      320,
      146,
      30,
      22
     ],
     "text": "0.3",
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
      356,
      146,
      30,
      22
     ],
     "text": "1.",
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
      388,
      146,
      30,
      22
     ],
     "text": "2.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      425,
      146,
      280,
      20
     ],
     "text": "one octave per speaker (multiband: bands)"
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      720,
      88,
      280,
      20
     ],
     "text": "one hot speaker (1-8), +6 dB pink:"
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "number",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      720,
      112,
      50,
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
     "id": "obj-20",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      720,
      140,
      40,
      22
     ],
     "text": "t i b",
     "outlettype": [
      "int",
      "bang"
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
      720,
      170,
      105,
      22
     ],
     "text": "setvalue $1 2.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      830,
      170,
      24,
      22
     ],
     "text": "0.",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      870,
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
     "id": "obj-24",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      870,
      204,
      66,
      22
     ],
     "text": "mc.*~ 0.",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      222,
      60,
      20
     ],
     "text": "layout",
     "fontface": 1
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
      222,
      395,
      22
     ],
     "text": "speaker_coords -22.5 22.5 67.5 112.5 157.5 -157.5 -112.5 -67.5, lfe, groups",
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
      80,
      248,
      360,
      22
     ],
     "text": "speaker_coords 30 -30 0 0 110 -110 150 -150, lfe 4, groups",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      450,
      248,
      200,
      22
     ],
     "text": "groups 1 1 1 2 3 3 3 3",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-29",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      480,
      222,
      480,
      20
     ],
     "text": "octagon; groups empty = all mains together, LFE apart"
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      660,
      248,
      360,
      20
     ],
     "text": "7.1: front / LFE / surrounds linked separately"
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "bands",
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
      185,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "crossovers",
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
      350,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "threshold",
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
      515,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "ratio",
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
      680,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "attack",
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
      845,
      282,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "release",
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
      20,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "makeup",
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
      185,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "link",
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
      350,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "link_detect",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "detector",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      680,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "solo",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-42",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      308,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "select_band",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-43",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      334,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "bypass",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      334,
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
     "id": "obj-45",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      334,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "gr_range",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      334,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "lookahead",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      366,
      330,
      22
     ],
     "text": "threshold -30 -24 -24 -30, ratio 3 2 2 3, crossovers 150 1500 7000",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      360,
      366,
      400,
      20
     ],
     "text": "per-band lists (a shorter list repeats its last value)"
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      394,
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
     "id": "obj-50",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      66,
      394,
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
     "id": "obj-51",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      102,
      394,
      700,
      20
     ],
     "text": "reset: max values and statistics. Click a meter to highlight a channel (history row, curve dot)."
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "mc.syncSuite.multiband~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      20,
      494,
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
     "id": "obj-53",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      694,
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
     "id": "obj-54",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      724,
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
     "id": "obj-55",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      754,
      84,
      22
     ],
     "text": "mc.dac~ 1 2"
    }
   },
   {
    "box": {
     "id": "obj-56",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      215,
      694,
      360,
      20
     ],
     "text": "listen on headphones (same layout messages)"
    }
   },
   {
    "box": {
     "id": "obj-57",
     "maxclass": "ezdac~",
     "numinlets": 2,
     "numoutlets": 0,
     "patching_rect": [
      120,
      744,
      45,
      45
     ]
    }
   },
   {
    "box": {
     "id": "obj-58",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      620,
      694,
      105,
      22
     ],
     "text": "print multiband"
    }
   },
   {
    "box": {
     "id": "obj-59",
     "maxclass": "newobj",
     "numinlets": 3,
     "numoutlets": 3,
     "patching_rect": [
      620,
      724,
      170,
      22
     ],
     "text": "route image latency",
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-60",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      620,
      754,
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
     "id": "obj-61",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      620,
      784,
      220,
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
     "id": "obj-62",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      850,
      754,
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
     "id": "obj-63",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      850,
      784,
      120,
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
     "id": "obj-64",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      620,
      810,
      380,
      34
     ],
     "text": "image: shift (deg), width change (rE), input / output azimuth. latency: samples, ms (report it to the host).",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-65",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      850,
      980,
      48
     ],
     "text": "Outlet 2 (on get, or every frame with @output 1): gr / gr_max / in_peak_max / out_peak_max <per channel, dB>, gr_band <band> <per channel>, image <shift width az_in az_out>, stats <gr_max reducing_% seconds clips>, latency <samples ms> (also whenever it changes). Gain reduction = the gain actually multiplied into the audio (excluding make-up / drive).",
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
      430,
      160,
      22
     ],
     "parameter_enable": 0,
     "id": "obj-66"
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
      430,
      330,
      20
     ],
     "id": "obj-67"
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
      460,
      470,
      20
     ],
     "id": "obj-68"
    }
   },
   {
    "box": {
     "maxclass": "mc.syncSuite.multiband~",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "multichannelsignal",
      ""
     ],
     "patching_rect": [
      500,
      458,
      226.4,
      22
     ],
     "no_ui": 1,
     "id": "obj-69"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-5",
      1
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
      "obj-5",
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
      "obj-5",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      0
     ],
     "destination": [
      "obj-5",
      1
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
      "obj-5",
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
      "obj-12",
      1
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
      "obj-12",
      1
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
      "obj-12",
      1
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
      "obj-12",
      1
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
      "obj-12",
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
      "obj-20",
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
      "obj-21",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
      1
     ],
     "destination": [
      "obj-22",
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
      "obj-24",
      1
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
      "obj-24",
      1
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
      "obj-24",
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
      "obj-52",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-12",
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
      "obj-24",
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
      "obj-26",
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
      "obj-27",
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
      "obj-28",
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
      "obj-49",
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
      "obj-50",
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
      "obj-47",
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
      "obj-31",
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
      "obj-32",
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
      "obj-33",
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
      "obj-34",
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
      "obj-35",
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
      "obj-36",
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
      "obj-37",
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
      "obj-38",
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
      "obj-39",
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
      "obj-40",
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
      "obj-41",
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
      "obj-42",
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
      "obj-43",
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
      "obj-44",
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
      "obj-45",
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
      "obj-46",
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
      "obj-53",
      0
     ],
     "destination": [
      "obj-54",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-54",
      0
     ],
     "destination": [
      "obj-55",
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
      "obj-53",
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
      "obj-53",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-52",
      1
     ],
     "destination": [
      "obj-58",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-52",
      1
     ],
     "destination": [
      "obj-59",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-59",
      0
     ],
     "destination": [
      "obj-60",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-60",
      0
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-59",
      1
     ],
     "destination": [
      "obj-62",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-62",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-66",
      0
     ],
     "destination": [
      "obj-52",
      0
     ]
    }
   }
  ]
 }
}