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
   840
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
     "text": "mc.syncSuite.reverb~",
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
     "text": "A reverb that lives in the speaker space. The speakers are sources inside a room around the listener: early reflections from their image sources arrive from where they would (click a speaker in the room panel to see its own), the late field is a decorrelated diffuse tail on every speaker, and one rt60 drives both (Sabine). Levels are physical by default: the reverb / direct balance of that room at the speaker distance.",
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
      300,
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
     "text": "mc.*~ 1.",
     "outlettype": [
      "multichannelsignal"
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
      208,
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
     "id": "obj-7",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "patching_rect": [
      160,
      176,
      50,
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
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      160,
      146,
      80,
      22
     ],
     "text": "1, 0 60",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      250,
      146,
      70,
      22
     ],
     "text": "metro 1500",
     "outlettype": [
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      250,
      118,
      22,
      22
     ],
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      280,
      118,
      300,
      20
     ],
     "text": "60 ms noise bursts: hear the room"
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "number",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      360,
      146,
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
     "id": "obj-13",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      360,
      176,
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
     "id": "obj-14",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      410,
      176,
      95,
      22
     ],
     "text": "setvalue $1 1.",
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
      510,
      176,
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
     "id": "obj-16",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      540,
      176,
      24,
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
     "id": "obj-17",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      416,
      146,
      400,
      20
     ],
     "text": "one speaker (1-8) / 1. = all"
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      244,
      60,
      20
     ],
     "text": "layout",
     "fontface": 1
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
      244,
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
     "id": "obj-20",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      270,
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
     "id": "obj-21",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      480,
      244,
      500,
      20
     ],
     "text": "octagon (syncSuite.nodes' default ring)"
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      420,
      270,
      560,
      20
     ],
     "text": "7.1: L R C LFE Ls Rs Lb Rb"
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      300,
      60,
      20
     ],
     "text": "rooms",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      300,
      270,
      22
     ],
     "text": "room 5 4 3, rt60 0.5 0.4 0.3, speaker_distance 1.5",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      356,
      300,
      250,
      22
     ],
     "text": "room 18 14 7, rt60 2.4 2 1.2, speaker_distance 2.5",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      612,
      300,
      280,
      22
     ],
     "text": "room 60 40 25, rt60 6 4.5 2.5, speaker_distance 4",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      80,
      324,
      700,
      20
     ],
     "text": "studio / hall / cathedral: the reflections, the onset and the reverb / direct balance all follow"
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "mc.syncSuite.reverb~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      20,
      440,
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
     "id": "obj-29",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "er_order",
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
      185,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "predelay",
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
      350,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "er",
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
      515,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "late",
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
      680,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "wet",
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
      845,
      350,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "dry",
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
      20,
      376,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "diffusion",
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
      185,
      376,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "modulation",
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
      350,
      376,
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
     "id": "obj-38",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      515,
      376,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "lines",
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
      680,
      376,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "select",
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
      845,
      376,
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
     "id": "obj-41",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      402,
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
     "id": "obj-42",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      185,
      402,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "ear_height",
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
      350,
      402,
      160,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "speaker_distance",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      640,
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
     "id": "obj-45",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      60,
      640,
      110,
      22
     ],
     "text": "print reverb"
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      680,
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
     "id": "obj-47",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      20,
      710,
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
     "id": "obj-48",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      740,
      84,
      22
     ],
     "text": "mc.dac~ 1 2"
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      215,
      680,
      380,
      20
     ],
     "text": "listen on headphones (same layout messages)"
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "ezdac~",
     "numinlets": 2,
     "numoutlets": 0,
     "patching_rect": [
      120,
      730,
      45,
      45
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
      560,
      640,
      440,
      34
     ],
     "text": "No display at all, a standard object: type @no_ui 1 with the object. Same audio, no drawing, no timer.",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "mc.syncSuite.reverb~",
     "numinlets": 1,
     "numoutlets": 2,
     "patching_rect": [
      560,
      678,
      206.3,
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
     "id": "obj-53",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      770,
      980,
      48
     ],
     "text": "Outlet 2 (get, or every frame with @output 1): room <volume m3> <surface m2> <mean free path ms>, absorption <low mid high>, late_to_direct <dB>, onset <ms>, early / late <dB per channel>. LFE channels pass dry. No latency.",
     "linecount": 3
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-10",
      0
     ],
     "destination": [
      "obj-9",
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
      "obj-8",
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
      "obj-7",
      0
     ],
     "destination": [
      "obj-6",
      1
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
      "obj-13",
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
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-13",
      1
     ],
     "destination": [
      "obj-15",
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
      "obj-5",
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
      "obj-5",
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
      "obj-5",
      1
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
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
      "obj-28",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-28",
      1
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
      "obj-28",
      0
     ],
     "destination": [
      "obj-46",
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
      "obj-19",
      0
     ],
     "destination": [
      "obj-46",
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
      "obj-46",
      0
     ]
    }
   }
  ]
 }
}