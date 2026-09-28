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
   920,
   1035
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
      300,
      24
     ],
     "text": "syncSuite.nodes",
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
      860,
      20
     ],
     "text": "Multi-source spatializer UI: speakers and sources on a 2D field, VBAP / DBAP gains on request. Create it by typing syncSuite.nodes in an object box.",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "v8ui",
     "patching_rect": [
      20,
      525,
      360,
      360
     ],
     "filename": "syncSuite.nodes.js",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "comment",
     "patching_rect": [
      20,
      62,
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
     "id": "obj-5",
     "maxclass": "message",
     "patching_rect": [
      95,
      60,
      142,
      22
     ],
     "text": "speaker_coords -30 30",
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
      245,
      60,
      198,
      22
     ],
     "text": "speaker_coords -45 45 135 -135",
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
     "maxclass": "message",
     "patching_rect": [
      451,
      60,
      210,
      22
     ],
     "text": "speaker_coords -30 30 0 110 -110",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "message",
     "patching_rect": [
      95,
      85,
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
     "id": "obj-9",
     "maxclass": "comment",
     "patching_rect": [
      20,
      112,
      70,
      20
     ],
     "text": "sources",
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
     "id": "obj-10",
     "maxclass": "message",
     "patching_rect": [
      95,
      110,
      93,
      22
     ],
     "text": "num_sources 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "message",
     "patching_rect": [
      196,
      110,
      93,
      22
     ],
     "text": "num_sources 4",
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
      297,
      110,
      93,
      22
     ],
     "text": "num_sources 8",
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
      398,
      110,
      136,
      22
     ],
     "text": "sources_mode 0 1 0 0",
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
     "maxclass": "message",
     "patching_rect": [
      542,
      110,
      136,
      22
     ],
     "text": "sources_mode 0 0 0 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "comment",
     "patching_rect": [
      20,
      137,
      70,
      20
     ],
     "text": "position",
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
     "id": "obj-16",
     "maxclass": "message",
     "patching_rect": [
      95,
      135,
      105,
      22
     ],
     "text": "source 1 45 0.3",
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
     "maxclass": "message",
     "patching_rect": [
      208,
      135,
      136,
      22
     ],
     "text": "source_azimuth 1 -90",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "message",
     "patching_rect": [
      352,
      135,
      142,
      22
     ],
     "text": "source_distance 1 0.1",
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
      502,
      135,
      130,
      22
     ],
     "text": "source_xy 1 0.2 0.2",
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
      20,
      162,
      70,
      20
     ],
     "text": "algorithm",
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
     "id": "obj-21",
     "maxclass": "message",
     "patching_rect": [
      95,
      160,
      80,
      22
     ],
     "text": "algorithm 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "message",
     "patching_rect": [
      183,
      160,
      80,
      22
     ],
     "text": "algorithm 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "message",
     "patching_rect": [
      271,
      160,
      93,
      22
     ],
     "text": "algorithm 2 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "comment",
     "patching_rect": [
      20,
      187,
      70,
      20
     ],
     "text": "VBAP",
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
     "id": "obj-25",
     "maxclass": "message",
     "patching_rect": [
      95,
      185,
      124,
      22
     ],
     "text": "source_spread 0.25",
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
      227,
      185,
      105,
      22
     ],
     "text": "source_spread 0",
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
     "maxclass": "message",
     "patching_rect": [
      340,
      185,
      130,
      22
     ],
     "text": "vbap_center_blend 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "message",
     "patching_rect": [
      478,
      185,
      130,
      22
     ],
     "text": "vbap_center_blend 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-29",
     "maxclass": "comment",
     "patching_rect": [
      20,
      212,
      70,
      20
     ],
     "text": "DBAP",
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
     "id": "obj-30",
     "maxclass": "message",
     "patching_rect": [
      95,
      210,
      105,
      22
     ],
     "text": "source_blur 0.2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "message",
     "patching_rect": [
      208,
      210,
      93,
      22
     ],
     "text": "source_blur 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "message",
     "patching_rect": [
      309,
      210,
      99,
      22
     ],
     "text": "dbap_rolloff 6",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-33",
     "maxclass": "message",
     "patching_rect": [
      416,
      210,
      99,
      22
     ],
     "text": "dbap_rolloff 3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "message",
     "patching_rect": [
      523,
      210,
      80,
      22
     ],
     "text": "dbap_hull 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "message",
     "patching_rect": [
      611,
      210,
      80,
      22
     ],
     "text": "dbap_hull 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "comment",
     "patching_rect": [
      20,
      237,
      70,
      20
     ],
     "text": "speaker",
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
     "id": "obj-37",
     "maxclass": "message",
     "patching_rect": [
      95,
      235,
      124,
      22
     ],
     "text": "speaker_weight 1 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "message",
     "patching_rect": [
      227,
      235,
      111,
      22
     ],
     "text": "speaker_weight 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "message",
     "patching_rect": [
      346,
      235,
      93,
      22
     ],
     "text": "speaker 1 -60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "message",
     "patching_rect": [
      447,
      235,
      111,
      22
     ],
     "text": "speaker 2 45 0.3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "message",
     "patching_rect": [
      566,
      235,
      142,
      22
     ],
     "text": "speaker_azimuth 1 -30",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-42",
     "maxclass": "comment",
     "patching_rect": [
      20,
      262,
      70,
      20
     ],
     "text": "stereo",
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
     "id": "obj-43",
     "maxclass": "message",
     "patching_rect": [
      95,
      260,
      117,
      22
     ],
     "text": "stereo_width 1 90",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "message",
     "patching_rect": [
      220,
      260,
      105,
      22
     ],
     "text": "stereo_width 60",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-45",
     "maxclass": "comment",
     "patching_rect": [
      20,
      287,
      70,
      20
     ],
     "text": "levels",
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
     "id": "obj-46",
     "maxclass": "message",
     "patching_rect": [
      95,
      285,
      155,
      22
     ],
     "text": "distance_attenuation -6",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "message",
     "patching_rect": [
      258,
      285,
      148,
      22
     ],
     "text": "distance_attenuation 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "message",
     "patching_rect": [
      414,
      285,
      217,
      22
     ],
     "text": "source_distance_attenuation 1 -12",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "message",
     "patching_rect": [
      639,
      285,
      192,
      22
     ],
     "text": "source_distance_attenuation 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "comment",
     "patching_rect": [
      20,
      312,
      70,
      20
     ],
     "text": "mirror",
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
     "id": "obj-51",
     "maxclass": "message",
     "patching_rect": [
      95,
      310,
      124,
      22
     ],
     "text": "mirror_sources 1 2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "message",
     "patching_rect": [
      227,
      310,
      142,
      22
     ],
     "text": "mirror_sources 3 4 fb",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-53",
     "maxclass": "message",
     "patching_rect": [
      377,
      310,
      161,
      22
     ],
     "text": "mirror_sources 1 3 point",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-54",
     "maxclass": "message",
     "patching_rect": [
      546,
      310,
      99,
      22
     ],
     "text": "mirror_sources",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-55",
     "maxclass": "comment",
     "patching_rect": [
      20,
      337,
      70,
      20
     ],
     "text": "get",
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
     "id": "obj-56",
     "maxclass": "message",
     "patching_rect": [
      95,
      335,
      80,
      22
     ],
     "text": "get_gains 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-57",
     "maxclass": "message",
     "patching_rect": [
      183,
      335,
      74,
      22
     ],
     "text": "get_source",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-58",
     "maxclass": "message",
     "patching_rect": [
      265,
      335,
      86,
      22
     ],
     "text": "get_source 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-59",
     "maxclass": "message",
     "patching_rect": [
      359,
      335,
      86,
      22
     ],
     "text": "get_speakers",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-60",
     "maxclass": "message",
     "patching_rect": [
      453,
      335,
      37,
      22
     ],
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-61",
     "maxclass": "message",
     "patching_rect": [
      498,
      335,
      105,
      22
     ],
     "text": "select_source 2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-62",
     "maxclass": "comment",
     "patching_rect": [
      20,
      362,
      70,
      20
     ],
     "text": "geometry",
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
     "id": "obj-63",
     "maxclass": "message",
     "patching_rect": [
      95,
      360,
      86,
      22
     ],
     "text": "get_geometry",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-64",
     "maxclass": "message",
     "patching_rect": [
      189,
      360,
      99,
      22
     ],
     "text": "geometry polar",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-65",
     "maxclass": "message",
     "patching_rect": [
      296,
      360,
      124,
      22
     ],
     "text": "geometry cartesian",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-66",
     "maxclass": "message",
     "patching_rect": [
      428,
      360,
      80,
      22
     ],
     "text": "format list",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-67",
     "maxclass": "message",
     "patching_rect": [
      516,
      360,
      80,
      22
     ],
     "text": "format pair",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-68",
     "maxclass": "comment",
     "patching_rect": [
      20,
      387,
      70,
      20
     ],
     "text": "sizes",
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
     "id": "obj-69",
     "maxclass": "message",
     "patching_rect": [
      95,
      385,
      105,
      22
     ],
     "text": "speaker_size 14",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-70",
     "maxclass": "message",
     "patching_rect": [
      208,
      385,
      105,
      22
     ],
     "text": "speaker_size 22",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-71",
     "maxclass": "message",
     "patching_rect": [
      321,
      385,
      99,
      22
     ],
     "text": "source_size 16",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-72",
     "maxclass": "message",
     "patching_rect": [
      428,
      385,
      99,
      22
     ],
     "text": "source_size 24",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-73",
     "maxclass": "comment",
     "patching_rect": [
      720,
      62,
      160,
      20
     ],
     "text": "poll gains every 20 ms",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-74",
     "maxclass": "toggle",
     "patching_rect": [
      720,
      86,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-75",
     "maxclass": "newobj",
     "patching_rect": [
      720,
      112,
      72,
      22
     ],
     "text": "qmetro 20",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-76",
     "maxclass": "message",
     "patching_rect": [
      720,
      138,
      68,
      22
     ],
     "text": "get_gains",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-77",
     "maxclass": "toggle",
     "patching_rect": [
      20,
      420,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-78",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      446,
      146,
      22
     ],
     "text": "prepend edit_speakers",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-79",
     "maxclass": "comment",
     "patching_rect": [
      42,
      420,
      120,
      20
     ],
     "text": "edit_speakers",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-80",
     "maxclass": "toggle",
     "patching_rect": [
      195,
      420,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-81",
     "maxclass": "newobj",
     "patching_rect": [
      195,
      446,
      146,
      22
     ],
     "text": "prepend draw_distance",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-82",
     "maxclass": "comment",
     "patching_rect": [
      217,
      420,
      120,
      20
     ],
     "text": "draw_distance",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-83",
     "maxclass": "toggle",
     "patching_rect": [
      370,
      420,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-84",
     "maxclass": "newobj",
     "patching_rect": [
      370,
      446,
      134,
      22
     ],
     "text": "prepend draw_spread",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-85",
     "maxclass": "comment",
     "patching_rect": [
      392,
      420,
      120,
      20
     ],
     "text": "draw_spread",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-86",
     "maxclass": "toggle",
     "patching_rect": [
      545,
      420,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-87",
     "maxclass": "newobj",
     "patching_rect": [
      545,
      446,
      140,
      22
     ],
     "text": "prepend draw_sources",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-88",
     "maxclass": "comment",
     "patching_rect": [
      567,
      420,
      120,
      20
     ],
     "text": "draw_sources",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-89",
     "maxclass": "toggle",
     "patching_rect": [
      20,
      476,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-90",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      502,
      146,
      22
     ],
     "text": "prepend draw_speakers",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-91",
     "maxclass": "comment",
     "patching_rect": [
      42,
      476,
      120,
      20
     ],
     "text": "draw_speakers",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-92",
     "maxclass": "toggle",
     "patching_rect": [
      195,
      476,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-93",
     "maxclass": "newobj",
     "patching_rect": [
      195,
      502,
      152,
      22
     ],
     "text": "prepend draw_intensity",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-94",
     "maxclass": "comment",
     "patching_rect": [
      217,
      476,
      120,
      20
     ],
     "text": "draw_intensity",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-95",
     "maxclass": "toggle",
     "patching_rect": [
      370,
      476,
      20,
      20
     ],
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-96",
     "maxclass": "newobj",
     "patching_rect": [
      370,
      502,
      121,
      22
     ],
     "text": "prepend bypass_ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-97",
     "maxclass": "comment",
     "patching_rect": [
      392,
      476,
      120,
      20
     ],
     "text": "bypass_ui",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-98",
     "maxclass": "comment",
     "patching_rect": [
      20,
      895,
      760,
      20
     ],
     "text": "drag = move source \u00b7 cmd-drag up/down = spread (VBAP) / blur (DBAP), drawn as a halo \u00b7 shift-drag = stereo width \u00b7 edit_speakers 1: drag speaker = move",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-99",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      923,
      84,
      22
     ],
     "text": "print gains",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-100",
     "maxclass": "newobj",
     "patching_rect": [
      120,
      923,
      103,
      22
     ],
     "text": "print analysis",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-101",
     "maxclass": "newobj",
     "patching_rect": [
      240,
      923,
      84,
      22
     ],
     "text": "print state",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-102",
     "maxclass": "comment",
     "patching_rect": [
      20,
      951,
      760,
      20
     ],
     "text": "out 0: get_gains -> <source> <channel> <g1> ... <gN>  (channel 1 = mono/L, 2 = R; sum of squares = 1)",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-103",
     "maxclass": "comment",
     "patching_rect": [
      20,
      971,
      760,
      20
     ],
     "text": "out 1: hull_distance (DBAP) and get_geometry   out 2: state (get_source, get_speakers, dump, mouse edits)   layout warnings -> Max console",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-104",
     "maxclass": "comment",
     "patching_rect": [
      420,
      525,
      320,
      62
     ],
     "text": "Automation: with output_source_position 1, mouse moves come out of out 2 as source <i> <az> <dist>, into live.dial and back in. Inlet messages never echo, so there is no loop.",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-105",
     "maxclass": "message",
     "patching_rect": [
      420,
      593,
      161,
      22
     ],
     "text": "output_source_position 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-106",
     "maxclass": "message",
     "patching_rect": [
      595,
      593,
      161,
      22
     ],
     "text": "output_source_position 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-107",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      625,
      90,
      22
     ],
     "text": "route source",
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
     "id": "obj-108",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      653,
      59,
      22
     ],
     "text": "route 1",
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
     "id": "obj-109",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      681,
      78,
      22
     ],
     "text": "unpack f f",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-110",
     "maxclass": "live.dial",
     "patching_rect": [
      420,
      713,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "source1_azimuth",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "source1 azimuth",
       "parameter_shortname": "s1 az",
       "parameter_mmin": -180.0,
       "parameter_mmax": 180.0,
       "parameter_type": 0,
       "parameter_unitstyle": 1,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.0
       ]
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-111",
     "maxclass": "live.dial",
     "patching_rect": [
      510,
      713,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "source1_distance",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "source1 distance",
       "parameter_shortname": "s1 dist",
       "parameter_mmin": 0.0,
       "parameter_mmax": 0.7071,
       "parameter_type": 0,
       "parameter_unitstyle": 1,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.3
       ]
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-112",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      775,
      165,
      22
     ],
     "text": "prepend source_azimuth 1",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-113",
     "maxclass": "newobj",
     "patching_rect": [
      590,
      775,
      171,
      22
     ],
     "text": "prepend source_distance 1",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-114",
     "maxclass": "comment",
     "patching_rect": [
      420,
      805,
      320,
      34
     ],
     "text": "same idea for source_spread, source_blur, stereo_width, speaker <i> <az> <dist>",
     "numinlets": 1,
     "numoutlets": 0
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-48",
      0
     ],
     "destination": [
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-57",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-58",
      0
     ],
     "destination": [
      "obj-3",
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
      "obj-3",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-61",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-63",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-64",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-65",
      0
     ],
     "destination": [
      "obj-3",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-67",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-69",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-70",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-71",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-72",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-74",
      0
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-75",
      0
     ],
     "destination": [
      "obj-76",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-76",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-77",
      0
     ],
     "destination": [
      "obj-78",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-78",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-80",
      0
     ],
     "destination": [
      "obj-81",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-81",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-83",
      0
     ],
     "destination": [
      "obj-84",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-84",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-87",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-87",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-89",
      0
     ],
     "destination": [
      "obj-90",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-90",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-92",
      0
     ],
     "destination": [
      "obj-93",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-93",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-95",
      0
     ],
     "destination": [
      "obj-96",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-96",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      0
     ],
     "destination": [
      "obj-99",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      1
     ],
     "destination": [
      "obj-100",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      2
     ],
     "destination": [
      "obj-101",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-105",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-106",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      2
     ],
     "destination": [
      "obj-107",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-107",
      0
     ],
     "destination": [
      "obj-108",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-108",
      0
     ],
     "destination": [
      "obj-109",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-109",
      0
     ],
     "destination": [
      "obj-110",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-109",
      1
     ],
     "destination": [
      "obj-111",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-112",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-111",
      0
     ],
     "destination": [
      "obj-113",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-112",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-113",
      0
     ],
     "destination": [
      "obj-3",
      0
     ]
    }
   }
  ]
 }
}