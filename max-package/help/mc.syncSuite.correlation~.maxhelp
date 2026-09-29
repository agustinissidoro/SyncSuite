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
   630
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
     "text": "mc.syncSuite.correlation~",
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
     "text": "How the channels of a layout relate. Matrix: cyan = opposite, pink = identical (click a cell for the scope). Ring: adjacent pairs, and each speaker's mono compatibility. Fold: the stereo / mono fold-down adds coherently (yellow: build-up, comb filtering) or cancels (cyan). Broadband, or low / mid / high.",
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
     "text": "test: 1 = 2 (identical), 3 = -1 (anti-phase), 4 independent",
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
      60,
      22
     ],
     "text": "pink~",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      90,
      112,
      60,
      22
     ],
     "text": "noise~",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      142,
      50,
      22
     ],
     "text": "*~ -1.",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "numinlets": 4,
     "numoutlets": 1,
     "patching_rect": [
      20,
      176,
      150,
      22
     ],
     "text": "mc.pack~ 4",
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "mc.syncSuite.correlation~",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      320,
      980,
      190
     ],
     "outlettype": [
      ""
     ],
     "speaker_coords": [
      -30.0,
      30.0,
      110.0,
      -110.0
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
      20,
      212,
      260,
      22
     ],
     "text": "speaker_coords -30 30 110 -110",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      250,
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
     "id": "obj-11",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      250,
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
     "id": "obj-12",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      250,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "band",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      250,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "pair",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      680,
      250,
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
     "id": "obj-15",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      250,
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
     "id": "obj-16",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      276,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "output",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      276,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "interval",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      520,
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
     "id": "obj-19",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      60,
      520,
      120,
      22
     ],
     "text": "print correlation"
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      556,
      980,
      48
     ],
     "text": "Outlet (get, or every frame with @output 1): matrix <C x C>, mono <per channel>, fold <L R M dB>, mean_abs, for the band shown. 0 dB fold = the channels add as uncorrelated signals. Analysis only: nothing is output as audio.",
     "linecount": 3
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
      "obj-6",
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
      "obj-7",
      1
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
      2
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
      3
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
      0
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
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
      "obj-8",
      0
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
      "obj-19",
      0
     ]
    }
   }
  ]
 }
}