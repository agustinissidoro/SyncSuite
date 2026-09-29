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
   1060
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
      550,
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
     "text": "source 1 45 0.6",
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
      117,
      22
     ],
     "text": "source_spread 0.5",
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
      220,
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
      333,
      185,
      99,
      22
     ],
     "text": "spread_focus 1",
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
      440,
      185,
      111,
      22
     ],
     "text": "spread_focus 1.6",
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
     "maxclass": "message",
     "patching_rect": [
      559,
      185,
      99,
      22
     ],
     "text": "spread_focus 3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
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
     "id": "obj-31",
     "maxclass": "message",
     "patching_rect": [
      233,
      210,
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
     "id": "obj-32",
     "maxclass": "comment",
     "patching_rect": [
      20,
      237,
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
     "id": "obj-33",
     "maxclass": "message",
     "patching_rect": [
      95,
      235,
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
     "id": "obj-34",
     "maxclass": "message",
     "patching_rect": [
      208,
      235,
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
     "id": "obj-35",
     "maxclass": "message",
     "patching_rect": [
      309,
      235,
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
     "id": "obj-36",
     "maxclass": "message",
     "patching_rect": [
      416,
      235,
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
     "id": "obj-37",
     "maxclass": "message",
     "patching_rect": [
      523,
      235,
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
     "id": "obj-38",
     "maxclass": "message",
     "patching_rect": [
      611,
      235,
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
     "id": "obj-39",
     "maxclass": "comment",
     "patching_rect": [
      20,
      262,
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
     "id": "obj-40",
     "maxclass": "message",
     "patching_rect": [
      95,
      260,
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
     "id": "obj-41",
     "maxclass": "message",
     "patching_rect": [
      227,
      260,
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
     "id": "obj-42",
     "maxclass": "message",
     "patching_rect": [
      346,
      260,
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
     "id": "obj-43",
     "maxclass": "message",
     "patching_rect": [
      447,
      260,
      111,
      22
     ],
     "text": "speaker 2 45 0.7",
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
      566,
      260,
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
     "id": "obj-45",
     "maxclass": "comment",
     "patching_rect": [
      20,
      287,
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
     "id": "obj-46",
     "maxclass": "message",
     "patching_rect": [
      95,
      285,
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
     "id": "obj-47",
     "maxclass": "message",
     "patching_rect": [
      208,
      285,
      111,
      22
     ],
     "text": "stereo_width 120",
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
      327,
      285,
      161,
      22
     ],
     "text": "source_stereo_width 1 90",
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
      496,
      285,
      142,
      22
     ],
     "text": "source_stereo_width 1",
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
     "id": "obj-51",
     "maxclass": "message",
     "patching_rect": [
      95,
      310,
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
     "id": "obj-52",
     "maxclass": "message",
     "patching_rect": [
      258,
      310,
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
     "id": "obj-53",
     "maxclass": "message",
     "patching_rect": [
      414,
      310,
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
     "id": "obj-54",
     "maxclass": "message",
     "patching_rect": [
      639,
      310,
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
     "id": "obj-55",
     "maxclass": "comment",
     "patching_rect": [
      20,
      337,
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
     "id": "obj-56",
     "maxclass": "message",
     "patching_rect": [
      95,
      335,
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
     "id": "obj-57",
     "maxclass": "message",
     "patching_rect": [
      227,
      335,
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
     "id": "obj-58",
     "maxclass": "message",
     "patching_rect": [
      377,
      335,
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
     "id": "obj-59",
     "maxclass": "message",
     "patching_rect": [
      546,
      335,
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
     "id": "obj-60",
     "maxclass": "comment",
     "patching_rect": [
      20,
      362,
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
     "id": "obj-61",
     "maxclass": "message",
     "patching_rect": [
      95,
      360,
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
     "id": "obj-62",
     "maxclass": "message",
     "patching_rect": [
      183,
      360,
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
     "id": "obj-63",
     "maxclass": "message",
     "patching_rect": [
      265,
      360,
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
     "id": "obj-64",
     "maxclass": "message",
     "patching_rect": [
      359,
      360,
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
     "id": "obj-65",
     "maxclass": "message",
     "patching_rect": [
      453,
      360,
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
     "id": "obj-66",
     "maxclass": "message",
     "patching_rect": [
      498,
      360,
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
     "id": "obj-67",
     "maxclass": "comment",
     "patching_rect": [
      20,
      387,
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
     "id": "obj-68",
     "maxclass": "message",
     "patching_rect": [
      95,
      385,
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
     "id": "obj-69",
     "maxclass": "message",
     "patching_rect": [
      189,
      385,
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
     "id": "obj-70",
     "maxclass": "message",
     "patching_rect": [
      296,
      385,
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
     "id": "obj-71",
     "maxclass": "message",
     "patching_rect": [
      428,
      385,
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
     "id": "obj-72",
     "maxclass": "message",
     "patching_rect": [
      516,
      385,
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
     "id": "obj-73",
     "maxclass": "comment",
     "patching_rect": [
      20,
      412,
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
     "id": "obj-74",
     "maxclass": "message",
     "patching_rect": [
      95,
      410,
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
     "id": "obj-75",
     "maxclass": "message",
     "patching_rect": [
      208,
      410,
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
     "id": "obj-76",
     "maxclass": "message",
     "patching_rect": [
      321,
      410,
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
     "id": "obj-77",
     "maxclass": "message",
     "patching_rect": [
      428,
      410,
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
     "id": "obj-78",
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
     "id": "obj-79",
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
     "id": "obj-80",
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
     "id": "obj-81",
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
     "id": "obj-82",
     "maxclass": "toggle",
     "patching_rect": [
      20,
      445,
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
     "id": "obj-83",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      471,
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
     "id": "obj-84",
     "maxclass": "comment",
     "patching_rect": [
      42,
      445,
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
     "id": "obj-85",
     "maxclass": "toggle",
     "patching_rect": [
      195,
      445,
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
     "id": "obj-86",
     "maxclass": "newobj",
     "patching_rect": [
      195,
      471,
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
     "id": "obj-87",
     "maxclass": "comment",
     "patching_rect": [
      217,
      445,
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
     "id": "obj-88",
     "maxclass": "toggle",
     "patching_rect": [
      370,
      445,
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
     "id": "obj-89",
     "maxclass": "newobj",
     "patching_rect": [
      370,
      471,
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
     "id": "obj-90",
     "maxclass": "comment",
     "patching_rect": [
      392,
      445,
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
     "id": "obj-91",
     "maxclass": "toggle",
     "patching_rect": [
      545,
      445,
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
     "id": "obj-92",
     "maxclass": "newobj",
     "patching_rect": [
      545,
      471,
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
     "id": "obj-93",
     "maxclass": "comment",
     "patching_rect": [
      567,
      445,
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
     "id": "obj-94",
     "maxclass": "toggle",
     "patching_rect": [
      20,
      501,
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
     "id": "obj-95",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      527,
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
     "id": "obj-96",
     "maxclass": "comment",
     "patching_rect": [
      42,
      501,
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
     "id": "obj-97",
     "maxclass": "toggle",
     "patching_rect": [
      195,
      501,
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
     "id": "obj-98",
     "maxclass": "newobj",
     "patching_rect": [
      195,
      527,
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
     "id": "obj-99",
     "maxclass": "comment",
     "patching_rect": [
      217,
      501,
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
     "id": "obj-100",
     "maxclass": "toggle",
     "patching_rect": [
      370,
      501,
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
     "id": "obj-101",
     "maxclass": "newobj",
     "patching_rect": [
      370,
      527,
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
     "id": "obj-102",
     "maxclass": "comment",
     "patching_rect": [
      392,
      501,
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
     "id": "obj-103",
     "maxclass": "comment",
     "patching_rect": [
      20,
      920,
      760,
      20
     ],
     "text": "drag = move source \u00b7 cmd-drag up/down = spread (VBAP) / blur (DBAP), drawn as a halo \u00b7 shift-drag = source stereo width \u00b7 edit_speakers 1: drag speaker = move",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-104",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      948,
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
     "id": "obj-105",
     "maxclass": "newobj",
     "patching_rect": [
      120,
      948,
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
     "id": "obj-106",
     "maxclass": "newobj",
     "patching_rect": [
      240,
      948,
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
     "id": "obj-107",
     "maxclass": "comment",
     "patching_rect": [
      20,
      976,
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
     "id": "obj-108",
     "maxclass": "comment",
     "patching_rect": [
      20,
      996,
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
     "id": "obj-109",
     "maxclass": "comment",
     "patching_rect": [
      420,
      550,
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
     "id": "obj-110",
     "maxclass": "message",
     "patching_rect": [
      420,
      618,
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
     "id": "obj-111",
     "maxclass": "message",
     "patching_rect": [
      595,
      618,
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
     "id": "obj-112",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      650,
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
     "id": "obj-113",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      678,
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
     "id": "obj-114",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      706,
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
     "id": "obj-115",
     "maxclass": "live.dial",
     "patching_rect": [
      420,
      738,
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
     "id": "obj-116",
     "maxclass": "live.dial",
     "patching_rect": [
      510,
      738,
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
       "parameter_mmax": 1.0,
       "parameter_type": 0,
       "parameter_unitstyle": 1,
       "parameter_initial_enable": 1,
       "parameter_initial": [
        0.6
       ]
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-117",
     "maxclass": "newobj",
     "patching_rect": [
      420,
      800,
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
     "id": "obj-118",
     "maxclass": "newobj",
     "patching_rect": [
      590,
      800,
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
     "id": "obj-119",
     "maxclass": "comment",
     "patching_rect": [
      420,
      830,
      320,
      34
     ],
     "text": "same idea for source_spread, source_blur, source_stereo_width, speaker <i> <az> <dist>",
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
      "obj-29",
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
      "obj-36",
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
      "obj-42",
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
      "obj-62",
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
      "obj-68",
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
      "obj-3",
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
      "obj-3",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-79",
      0
     ],
     "destination": [
      "obj-80",
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
      "obj-82",
      0
     ],
     "destination": [
      "obj-83",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-85",
      0
     ],
     "destination": [
      "obj-86",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-88",
      0
     ],
     "destination": [
      "obj-89",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-91",
      0
     ],
     "destination": [
      "obj-92",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-94",
      0
     ],
     "destination": [
      "obj-95",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-97",
      0
     ],
     "destination": [
      "obj-98",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-98",
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
      "obj-100",
      0
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
      "obj-101",
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
      "obj-104",
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
      "obj-105",
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
      "obj-106",
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
      "obj-3",
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
      "obj-112",
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
      "obj-113",
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
      "obj-114",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-114",
      0
     ],
     "destination": [
      "obj-115",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-114",
      1
     ],
     "destination": [
      "obj-116",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-115",
      0
     ],
     "destination": [
      "obj-117",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-116",
      0
     ],
     "destination": [
      "obj-118",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-117",
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
      "obj-118",
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