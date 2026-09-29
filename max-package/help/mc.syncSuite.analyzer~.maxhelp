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
     "text": "mc.syncSuite.analyzer~",
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
     "text": "Multichannel measurement display: speaker levels on the layout with energy vectors, meters (RMS, true peak, hold, max), programme loudness (BS.1770-4 / EBU R128: M, S, I, LRA, max true peak) and fractional-octave spectra (curve + speakers x bands heat map). One multichannel inlet, channel i = speaker i. No audio output: keep it off when not measuring.",
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
     "id": "obj-7",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      50,
      146,
      31,
      22
     ],
     "text": "0.1",
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
      31,
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
     "id": "obj-9",
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
     "id": "obj-10",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      290,
      112,
      410,
      22
     ],
     "text": "mc.cycle~ @chans 8 @values 63 125 250 500 1000 2000 4000 8000",
     "outlettype": [
      "multichannelsignal"
     ]
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
     "id": "obj-12",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      290,
      146,
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
     "id": "obj-13",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      320,
      146,
      31,
      22
     ],
     "text": "0.1",
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
      356,
      146,
      31,
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
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      395,
      146,
      300,
      20
     ],
     "text": "one octave per speaker: see the heat map diagonal"
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      720,
      88,
      260,
      20
     ],
     "text": "one speaker (1-8) of pink noise:"
    }
   },
   {
    "box": {
     "id": "obj-17",
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
     "id": "obj-18",
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
     "id": "obj-19",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      720,
      170,
      105,
      22
     ],
     "text": "setvalue $1 0.3",
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
     "id": "obj-21",
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
     "id": "obj-22",
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
     "id": "obj-23",
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
     "id": "obj-24",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      222,
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
     "id": "obj-25",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      248,
      300,
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
     "id": "obj-26",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      274,
      100,
      22
     ],
     "text": "speaker_coords",
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
      388,
      248,
      205,
      22
     ],
     "text": "speaker_elevations 0 0 0 0 45 45",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      185,
      274,
      520,
      20
     ],
     "text": "no coords = even ring of the non-LFE channels, all loudness weights 1"
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
      280,
      20
     ],
     "text": "octagon (as syncSuite.nodes' default ring)"
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      600,
      248,
      300,
      20
     ],
     "text": "7.1 order L R C LFE Ls Rs Lb Rb (1.41 weights at 60-120 deg)"
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
      302,
      60,
      20
     ],
     "text": "measure",
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      80,
      302,
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
     "id": "obj-33",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      126,
      302,
      72,
      22
     ],
     "text": "reset_peaks",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      204,
      302,
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
     "id": "obj-35",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      240,
      302,
      90,
      22
     ],
     "text": "get_spectrum 0",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      336,
      302,
      67,
      22
     ],
     "text": "get_bands",
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-37",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      480,
      384,
      520,
      34
     ],
     "text": "field: angle = direction, radius = frequency (low at the centre), colour = band power; dots = each band's energy direction, faded when diffuse",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      410,
      302,
      560,
      20
     ],
     "text": "reset: integrated, LRA, max values. Click a speaker, meter or heat-map row to see its spectrum (again = all)."
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      332,
      145,
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
     "id": "obj-40",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      170,
      332,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "spectrum_view",
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
      320,
      332,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "resolution",
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
      470,
      332,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "fftsize",
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
      620,
      332,
      145,
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
     "id": "obj-44",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      770,
      332,
      145,
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
     "id": "obj-45",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      358,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "truepeak",
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
      170,
      358,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "aes17",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      320,
      358,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "rms_window",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      470,
      358,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "spectrum_avg",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      620,
      358,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "meter_min",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      770,
      358,
      145,
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
     "id": "obj-51",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      384,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "field_mode",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      170,
      384,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "field_scale",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-53",
     "maxclass": "attrui",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      320,
      384,
      145,
      22
     ],
     "outlettype": [
      ""
     ],
     "attr": "field_range",
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-54",
     "maxclass": "mc.syncSuite.analyzer~",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      20,
      496,
      900,
      190
     ],
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-55",
     "maxclass": "ezdac~",
     "numinlets": 2,
     "numoutlets": 0,
     "patching_rect": [
      940,
      496,
      45,
      45
     ]
    }
   },
   {
    "box": {
     "id": "obj-56",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      940,
      544,
      100,
      34
     ],
     "text": "audio on / off",
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-57",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      20,
      700,
      105,
      22
     ],
     "text": "print analyzer"
    }
   },
   {
    "box": {
     "id": "obj-58",
     "maxclass": "newobj",
     "numinlets": 3,
     "numoutlets": 3,
     "patching_rect": [
      140,
      700,
      190,
      22
     ],
     "text": "route loudness energy",
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-59",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      140,
      730,
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
     "id": "obj-60",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      140,
      760,
      260,
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
     "id": "obj-61",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "patching_rect": [
      420,
      730,
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
     "id": "obj-62",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "patching_rect": [
      420,
      760,
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
     "id": "obj-63",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      140,
      786,
      270,
      20
     ],
     "text": "loudness M S I LRA (LUFS / LU)"
    }
   },
   {
    "box": {
     "id": "obj-64",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      420,
      786,
      300,
      20
     ],
     "text": "energy az el rE (broadband Gerzon vector)"
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
      816,
      1000,
      62
     ],
     "text": "Outlet (on get, or every frame with @output 1): loudness M S I LRA, max M S TP, time <s>, rms / peak / peak_max / channel_loudness <one value per channel>, energy / energy_low / energy_mid / energy_high <az el r>. get_spectrum <ch> (0 = power sum) -> spectrum <ch> <dB per band>; get_bands -> bands <centre Hz ...>. -inf is output as -200. Levels: 0 dB = full-scale square (a full-scale sine is -3.01 dB RMS) unless @aes17 1.",
     "linecount": 4
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
      432,
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
      432,
      330,
      20
     ],
     "id": "obj-67"
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
      "obj-10",
      0
     ],
     "destination": [
      "obj-11",
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
      "obj-11",
      1
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
      "obj-11",
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
      "obj-11",
      1
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
      "obj-18",
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
      "obj-19",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-18",
      1
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
      "obj-19",
      0
     ],
     "destination": [
      "obj-22",
      1
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
      "obj-22",
      1
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
      "obj-22",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-54",
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
      "obj-57",
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
      "obj-58",
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
      "obj-58",
      1
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
      "obj-61",
      0
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
      "obj-66",
      0
     ],
     "destination": [
      "obj-54",
      0
     ]
    }
   }
  ]
 }
}