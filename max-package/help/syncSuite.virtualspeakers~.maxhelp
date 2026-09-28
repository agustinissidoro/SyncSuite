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
   80,
   80,
   900,
   565
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
     "patching_rect": [
      20,
      8,
      400,
      24
     ],
     "text": "syncSuite.virtualspeakers~",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 16.0,
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      20,
      32,
      840,
      34
     ],
     "text": "One signal inlet per speaker (argument speakers_num, default 2), two signal outlets. For an mc cable use mc.syncSuite.virtualspeakers~. Hear a speaker layout on headphones (binaural) or as a stereo downmix.",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "comment",
     "patching_rect": [
      20,
      76,
      70,
      20
     ],
     "text": "layout",
     "numinlets": 1,
     "numoutlets": 0,
     "textcolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "message",
     "patching_rect": [
      95,
      74,
      396,
      22
     ],
     "text": "speaker_coords -22.5 22.5 67.5 112.5 157.5 -157.5 -112.5 -67.5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "message",
     "patching_rect": [
      95,
      100,
      279,
      22
     ],
     "text": "speaker_coords -30 30 0 110 -110 180 90 -90",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "message",
     "patching_rect": [
      382,
      100,
      99,
      22
     ],
     "text": "speaker_coords",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "comment",
     "patching_rect": [
      20,
      128,
      70,
      20
     ],
     "text": "mode",
     "numinlets": 1,
     "numoutlets": 0,
     "textcolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "message",
     "patching_rect": [
      95,
      126,
      105,
      22
     ],
     "text": "mode headphones",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "message",
     "patching_rect": [
      208,
      126,
      80,
      22
     ],
     "text": "mode stereo",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "comment",
     "patching_rect": [
      20,
      154,
      70,
      20
     ],
     "text": "rotate",
     "numinlets": 1,
     "numoutlets": 0,
     "textcolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "message",
     "patching_rect": [
      95,
      152,
      62,
      22
     ],
     "text": "rotate 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "message",
     "patching_rect": [
      165,
      152,
      68,
      22
     ],
     "text": "rotate 90",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "message",
     "patching_rect": [
      241,
      152,
      74,
      22
     ],
     "text": "rotate 180",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "comment",
     "patching_rect": [
      20,
      180,
      70,
      20
     ],
     "text": "gain",
     "numinlets": 1,
     "numoutlets": 0,
     "textcolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "message",
     "patching_rect": [
      95,
      178,
      49,
      22
     ],
     "text": "gain 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "message",
     "patching_rect": [
      152,
      178,
      55,
      22
     ],
     "text": "gain -6",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "comment",
     "patching_rect": [
      20,
      206,
      70,
      20
     ],
     "text": "hrtf",
     "numinlets": 1,
     "numoutlets": 0,
     "textcolor": [
      0.5,
      0.5,
      0.5,
      1.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "message",
     "patching_rect": [
      95,
      204,
      37,
      22
     ],
     "text": "hrtf",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "message",
     "patching_rect": [
      140,
      204,
      86,
      22
     ],
     "text": "hrtf default",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "comment",
     "patching_rect": [
      95,
      232,
      440,
      20
     ],
     "text": "speaker_coords with no values = default ring (2 = L/R, 4 = quad, 8 = octagon)",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "comment",
     "patching_rect": [
      250,
      206,
      360,
      20
     ],
     "text": "<- load a SOFA file (dialog) / back to the built-in KEMAR",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "comment",
     "patching_rect": [
      560,
      74,
      260,
      20
     ],
     "text": "play one speaker (1-8) on its own:",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "number",
     "patching_rect": [
      560,
      98,
      50,
      22
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0,
     "minimum": 1,
     "maximum": 8
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      560,
      126,
      47,
      22
     ],
     "text": "t i b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "message",
     "patching_rect": [
      560,
      154,
      105,
      22
     ],
     "text": "setvalue $1 0.3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "message",
     "patching_rect": [
      670,
      154,
      24,
      22
     ],
     "text": "0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      720,
      154,
      128,
      22
     ],
     "text": "mc.noise~ @chans 8",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "newobj",
     "patching_rect": [
      720,
      188,
      66,
      22
     ],
     "text": "mc.*~ 0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "multichannelsignal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-29",
     "maxclass": "newobj",
     "patching_rect": [
      720,
      222,
      180,
      22
     ],
     "text": "mc.unpack~ 8",
     "numinlets": 1,
     "numoutlets": 8,
     "outlettype": [
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal",
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "newobj",
     "patching_rect": [
      95,
      300,
      460,
      22
     ],
     "text": "syncSuite.virtualspeakers~ 8",
     "numinlets": 8,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "newobj",
     "patching_rect": [
      95,
      340,
      53,
      22
     ],
     "text": "*~ 0.5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "newobj",
     "patching_rect": [
      200,
      340,
      53,
      22
     ],
     "text": "*~ 0.5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-33",
     "maxclass": "ezdac~",
     "patching_rect": [
      95,
      375,
      45,
      45
     ],
     "numinlets": 2,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "comment",
     "patching_rect": [
      150,
      387,
      330,
      20
     ],
     "text": "turn audio on, pick a speaker, listen on headphones",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "comment",
     "patching_rect": [
      20,
      435,
      840,
      20
     ],
     "text": "With syncSuite.nodes: its get_speakers outputs speaker_coords <az...>, this object's layout message. From nodes' right outlet:",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      461,
      140,
      22
     ],
     "text": "route speaker_coords",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-37",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      489,
      152,
      22
     ],
     "text": "prepend speaker_coords",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "comment",
     "patching_rect": [
      170,
      461,
      260,
      20
     ],
     "text": "<- from syncSuite.nodes (right outlet)",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "comment",
     "patching_rect": [
      180,
      489,
      520,
      20
     ],
     "text": "-> into this object (feed it the speaker signals that syncSuite.nodes' gains produce)",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "comment",
     "patching_rect": [
      20,
      525,
      840,
      20
     ],
     "text": "HRIRs: MIT KEMAR, diffuse-field equalized (B. Gardner, K. Martin, MIT Media Lab Tech. Report #280, 1994). SOFA reading: libmysofa (BSD). Licenses: docs/licenses.",
     "numinlets": 1,
     "numoutlets": 0
    }
   }
  ],
  "lines": [
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
      "obj-24",
      1
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
      "obj-25",
      0
     ],
     "destination": [
      "obj-28",
      1
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
      "obj-28",
      1
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
      "obj-28",
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
      "obj-29",
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
      "obj-30",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      1
     ],
     "destination": [
      "obj-30",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      2
     ],
     "destination": [
      "obj-30",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      3
     ],
     "destination": [
      "obj-30",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      4
     ],
     "destination": [
      "obj-30",
      4
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      5
     ],
     "destination": [
      "obj-30",
      5
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      6
     ],
     "destination": [
      "obj-30",
      6
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      7
     ],
     "destination": [
      "obj-30",
      7
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
      "obj-31",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      1
     ],
     "destination": [
      "obj-32",
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
      "obj-33",
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
      "obj-33",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-30",
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
      "obj-37",
      0
     ]
    }
   }
  ]
 }
}