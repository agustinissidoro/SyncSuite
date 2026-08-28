{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 4,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 230.0, 117.0, 1139.0, 822.0 ],
        "openinpresentation": 1,
        "toolbarvisible": 0,
        "enablehscroll": 0,
        "title": "syncSuite",
        "boxes": [
            {
                "box": {
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 155.0, 581.0, 277.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 155.0, 581.0, 244.0, 20.0 ],
                    "text": "Get IP, scan and ping devices in the network"
                }
            },
            {
                "box": {
                    "id": "obj-55",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 18.0, 564.0, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.0, 564.0, 474.0, 9.0 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 19.0, 541.0, 124.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 19.0, 541.0, 115.0, 22.0 ],
                    "text": "network utilities"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-52",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 168.0, 503.0, 106.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.0, 580.0, 106.0, 22.0 ],
                    "text": "syncSuite.netscan"
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 700.0, 478.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 475.0, 373.0, 20.0 ],
                    "text": "Control and trigger cues in Live"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 699.0, 448.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 444.0, 373.0, 20.0 ],
                    "text": "Control and retrieve basic Live information via UDP"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 696.0, 417.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 413.0, 373.0, 20.0 ],
                    "text": "Write messages inside clips to send via UDP"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 699.0, 386.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 382.0, 373.0, 20.0 ],
                    "text": "Load and manage a score in a server"
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 697.0, 354.0, 284.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 350.0, 373.0, 20.0 ],
                    "text": "Web server to display and manage .pdf files in a local network"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 700.0, 327.0, 284.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 319.0, 373.0, 20.0 ],
                    "text": "Use clips as rendered text and syncronize them with a video context"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 694.0, 293.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 288.0, 373.0, 20.0 ],
                    "text": "Render and output video in Live"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 695.0, 262.0, 284.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 679.0, 257.0, 373.0, 20.0 ],
                    "text": "Use video files as clips and syncronize playback with a video context"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 544.0, 470.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 474.0, 151.0, 22.0 ],
                    "text": "CueSync"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-44",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 542.0, 440.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 443.0, 151.0, 22.0 ],
                    "text": "LiveSync"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-43",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 544.0, 412.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 412.0, 151.0, 22.0 ],
                    "text": "OSCSync"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 543.0, 384.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 381.0, 151.0, 22.0 ],
                    "text": "ScoreSync.part"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-41",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 545.0, 356.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 349.0, 151.0, 22.0 ],
                    "text": "ScoreSync.server"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 542.0, 327.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 318.0, 151.0, 22.0 ],
                    "text": "SubSync"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-39",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 539.0, 291.0, 123.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 287.0, 149.0, 22.0 ],
                    "text": "VideoOutSync"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-38",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 543.0, 262.0, 122.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 256.0, 152.0, 22.0 ],
                    "text": "VideoSourceSync"
                }
            },
            {
                "box": {
                    "fontsize": 10.0,
                    "id": "obj-37",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 689.0, 300.0, 299.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 706.0, 183.0, 411.0, 18.0 ],
                    "text": "All M4L devices are located in /m4l-devices in the main project folder. Get it from GitHub."
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 543.0, 232.0, 124.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 525.0, 227.0, 100.0, 22.0 ],
                    "text": "video devices"
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 38.0, 555.0, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.5, 612.0, 474.0, 9.0 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 20.0,
                    "id": "obj-34",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 38.0, 564.0, 172.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.5, 618.0, 123.0, 29.0 ],
                    "text": "Tutorials"
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 594.0, 541.0, 129.0, 35.0 ],
                    "text": ";\rmax launchbrowser $1"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "bgcolor2": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "bgfillcolor_color1": [ 0.501961, 0.501961, 0.501961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 594.0, 503.0, 260.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 860.0, 17.0, 260.0, 22.0 ],
                    "text": "https://github.com/agustinissidoro/SyncSuite.git",
                    "textcolor": [ 0.10196078431372549, 0.0, 1.0, 1.0 ]
                }
            },
            {
                "box": {
                    "border": 5.0,
                    "id": "obj-32",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 529.8968775272369, 352.57729983329773, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 507.0, 252.0, 16.0, 298.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 28.86597776412964, 720.6185163259506, 1102.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 770.0, 934.0, 20.0 ],
                    "text": "The syncSuite project was possible thanks to the support of Hamburg Online Open University (HOOU) and the Hochschule für Musik und Theater Hamburg (HfMT - Hamburg)"
                }
            },
            {
                "box": {
                    "fontface": 2,
                    "id": "obj-29",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 379.3814220428467, 83.50514996051788, 284.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 369.0, 77.0, 110.0, 33.0 ],
                    "text": "by Agustín Issidoro\nHamburg, 2026."
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 35.051544427871704, 404.12368869781494, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.0, 411.0, 474.0, 9.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 38.14432775974274, 248.45359432697296, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.0, 252.0, 474.0, 5.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 918.5566495656967, 321.6494665145874, 5.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 214.0, 1096.8556722402573, 18.556699991226196 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 66.0, 352.57729983329773, 124.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 19.0, 388.0, 99.0, 22.0 ],
                    "text": "score utilities"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 35.051544427871704, 217.52576100826263, 124.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 227.0, 98.0, 22.0 ],
                    "text": "video utilities"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 177.3195776939392, 449.45358312129974, 277.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 155.0, 508.0, 277.0, 20.0 ],
                    "text": "Load a .pdf file as a sequence of jitter matrices."
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 32.0, 448.45358312129974, 70.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 17.0, 508.0, 70.0, 22.0 ],
                    "text": "jit.pdfmatrix"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 177.3195776939392, 414.0, 277.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 155.0, 464.0, 277.0, 20.0 ],
                    "text": "Server for loading scores in web-browsers."
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 177.3195776939392, 381.0, 277.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 155.0, 420.0, 277.0, 20.0 ],
                    "text": "Cue manager and player."
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 181.0, 313.0, 277.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 158.0, 352.0, 339.0, 33.0 ],
                    "text": "Utility for rendering text in the syncSuite context and syncronization with Live. "
                }
            },
            {
                "box": {
                    "id": "obj-16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 32.0, 485.56698310375214, 48.0, 22.0 ],
                    "text": "help $1"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 32.0, 523.7113108634949, 51.0, 22.0 ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 181.0, 268.5, 284.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 158.0, 301.0, 339.0, 33.0 ],
                    "text": "Video source with efficient loading, pixel space projection and syncronization with Live."
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 181.0, 232.0, 284.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 158.0, 257.0, 339.0, 20.0 ],
                    "text": "Video rendering context with pixel space projection."
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-15",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 32.0, 413.0, 130.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 17.0, 464.0, 130.0, 22.0 ],
                    "text": "syncSuite.score.server"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 32.0, 380.0, 126.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 17.0, 420.0, 126.0, 22.0 ],
                    "text": "syncSuite.scoreplayer"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-13",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 34.5, 313.0, 121.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 351.0, 121.0, 22.0 ],
                    "text": "syncSuite.video.subs"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 34.5, 274.0, 132.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 306.0, 132.0, 22.0 ],
                    "text": "syncSuite.video.source"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgcolor2": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1.0 ],
                    "bgfillcolor_color1": [ 0.301961, 0.301961, 0.301961, 1.0 ],
                    "bgfillcolor_color2": [ 0.2, 0.2, 0.2, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "gradient": 1,
                    "id": "obj-11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 34.5, 232.0, 135.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 262.0, 135.0, 22.0 ],
                    "text": "syncSuite.video.context"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 20.0,
                    "id": "obj-9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 536.0, 188.0, 177.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 529.0, 183.0, 177.0, 29.0 ],
                    "text": "Max4Live devices"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 472.0, 188.0, 21.0, 326.0 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 20.0,
                    "id": "obj-4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 33.0, 188.0, 172.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 183.0, 123.0, 29.0 ],
                    "text": "Max objects"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 33.0, 178.0, 1076.0, 5.0 ]
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.7254901960784313, 0.7254901960784313, 0.7254901960784313, 1.0 ],
                    "id": "obj-5",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 33.0, 120.0, 1103.0, 33.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 18.0, 120.0, 1103.0, 33.0 ],
                    "text": "syncSuite is a cross-platform package (Max, Live, web-browsers) that offers solutions for sound, video and score syncronization and manipulation in the context of multimedia performance. The package has a focus on live performance so that it is simple to design reliable and performant technical solutions that support the whole process of production, including composition, rehearsals and performance. "
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 72.0,
                    "id": "obj-3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 33.0, 28.0, 349.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 18.0, 23.0, 349.0, 87.0 ],
                    "text": "syncSuite"
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "bgcolor": [ 0.6784313725490196, 0.6784313725490196, 0.6784313725490196, 1.0 ],
                    "bordercolor": [ 0.807843, 0.898039, 0.909804, 0.0 ],
                    "id": "obj-1",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 19.0, 11.0, 1140.0, 809.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 5.0, 7.0, 1127.8349883556366, 809.2783051729202 ],
                    "proportion": 0.5,
                    "rounded": 12
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-52", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}