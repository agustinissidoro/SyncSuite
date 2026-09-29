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
   700
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
     "text": "mc.syncSuite.decorrelator~",
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
     "text": "Decorrelates the channels of a layout without colouring them: each channel runs its own allpass cascade (flat magnitude, different phase). With one input and @channels N it spreads a mono source over N decorrelated speakers: no comb filtering, no collapse into a phantom image. Left: correlation before, right: after; each channel's impulse response.",
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
      400,
      20
     ],
     "text": "a mono source, spread over 8 speakers",
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
      70,
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
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      142,
      50,
      22
     ],
     "text": "*~ 0.2",
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "mc.syncSuite.decorrelator~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      20,
      300,
      980,
      190
     ],
     "outlettype": [
      "multichannelsignal",
      ""
     ],
     "channels": 8
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      100,
      112,
      500,
      20
     ],
     "text": "one channel in, @channels 8: eight decorrelated copies"
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      176,
      60,
      20
     ],
     "text": "layout",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      176,
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
     "id": "obj-10",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      202,
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
     "id": "obj-11",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      480,
      176,
      500,
      20
     ],
     "text": "octagon (syncSuite.nodes' default ring)"
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      420,
      202,
      560,
      20
     ],
     "text": "7.1: L R C LFE Ls Rs Lb Rb"
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      232,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "amount",
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
      185,
      232,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "length",
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
      350,
      232,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "transient",
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
      515,
      232,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "seed",
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
      680,
      232,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "channels",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      845,
      232,
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
     "id": "obj-19",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      258,
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
     "id": "obj-20",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      258,
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
     "id": "obj-21",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      350,
      258,
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
     "id": "obj-22",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      500,
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
     "id": "obj-23",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      60,
      500,
      130,
      22
     ],
     "text": "print decorrelator"
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      540,
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
     "id": "obj-25",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      570,
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
     "id": "obj-26",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      600,
      84,
      22
     ],
     "text": "mc.dac~ 1 2"
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      215,
      540,
      380,
      20
     ],
     "text": "listen on headphones (same layout messages)"
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "ezdac~",
     "numinlets": 2,
     "numoutlets": 0,
     "patching_rect": [
      120,
      590,
      45,
      45
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
      560,
      500,
      440,
      34
     ],
     "text": "No display, a standard object: type @no_ui 1 with the object.",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "mc.syncSuite.decorrelator~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      560,
      538,
      246.5,
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
     "id": "obj-31",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      630,
      980,
      48
     ],
     "text": "amount 0 = dry, bit for bit; 1 = decorrelated (constant energy in between). length: longer = lower correlation, more time smear. transient: attacks stay dry for a moment, so they keep their place. Parameter changes crossfade over 50 ms. No latency.",
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
      "obj-5",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
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
      "obj-6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-6",
      1
     ],
     "destination": [
      "obj-23",
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
      "obj-24",
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
      "obj-25",
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
      "obj-26",
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
      "obj-24",
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
      "obj-24",
      0
     ]
    }
   }
  ]
 }
}