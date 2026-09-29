#!/usr/bin/env python3
"""refpages.py - write the reference pages of the syncSuite C++ objects from their code.

For every object the attribute list comes from the source (name, type, size,
label -> digest, default, enum values, inspector category), so the refpage,
Max's autocompletion and the Inspector always match what the object really
accepts. Hand-written texts are kept: an existing refpage's object digest /
description, inlets, outlets, arguments, see-also and every attribute's or
message's description are carried over; OBJECTS below adds the texts of
objects and entries that have none yet.

  python3 tools/refpages.py            rewrite docs/refpages for the C++ objects
  python3 tools/check_docs.py          then verify the whole package
"""
import os
import re
import sys
import xml.etree.ElementTree as ET
from xml.sax.saxutils import escape

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from check_docs import CPP_OBJECTS, GITHUB, REF, preprocess  # noqa: E402

# --- common entries -----------------------------------------------------------------------------

COMMON_ATTRS = {
    "speaker_coords": ("float64", 128, "Speaker azimuths (deg, 0 = front, clockwise)", "", "Layout",
                       "One azimuth per channel (channel i = speaker i), the same message syncSuite.nodes uses and outputs (get_speakers). "
                       "Empty = an even ring of the non-LFE channels straddling the front (2 = L/R, 4 = quad, 8 = octagon)."),
    "speaker_elevations": ("float64", 128, "Speaker elevations (deg)", "", "Layout",
                           "Degrees, up, one per channel (missing = 0). All spatial computations are in 3D; the displays are top views."),
    "lfe": ("int", 128, "LFE channels (1-based)", "", "Layout",
            "Channels that are LFE: they have no position and are kept out of the spatial processing and the loudness. lfe with no values = none."),
    "view": ("int", 1, "View", "0", "Display", "Which panels are drawn: all, or one of them filling the box."),
    "bypass_ui": ("int", 1, "Stop drawing", "0", "Display",
                  "1: nothing is drawn and the display timer stops; the audio and the message output are not affected (use it when the box is hidden or while performing)."),
    "no_ui": ("int", 1, "No UI: a plain object box", "0", "Display",
              "Type it with the object (mc.syncSuite.limiter~ @no_ui 1): the box looks and sizes like a standard object box, draws nothing, "
              "runs no display timer and skips the display-only metering. Max decides per class whether a box is a UI box, so the box stays "
              "resizable, but it behaves as a standard object: audio, messages and get work as usual."),
    "output": ("int", 1, "Output measurements every frame", "0", "Display",
               "1: the measurements (see get) are output at every display refresh with new data. 0: only on get."),
    "interval": ("int", 1, "Refresh interval (ms)", "33", "Display", "Display refresh and output rate. The processing does not depend on it."),
    "bgcolor": ("float64", 4, "Background Color", "", "Color", "Box background (syncSuite style: near black)."),
    "panelcolor": ("float64", 4, "Panel Color", "", "Color", "Panel background."),
    "textcolor": ("float64", 4, "Text Color", "", "Color", "Labels and numbers."),
    "gridcolor": ("float64", 4, "Grid Color", "", "Color", "Scales and guides."),
    "color": ("float64", 4, "Signal Color", "", "Color", "Main signal colour (syncSuite hot pink)."),
    "alarmcolor": ("float64", 4, "Alarm Color", "", "Color", "Overs, clips, gated / frozen states (acid yellow)."),
    "overcolor": ("float64", 4, "Over Color", "", "Color", "Overs and clips (acid yellow)."),
    "grcolor": ("float64", 4, "Gain Reduction Color", "", "Color", "Gain reduction bars and curve."),
    "speakercolor": ("float64", 4, "Speaker Color", "", "Color", "Speakers."),
}

COMMON_METHODS = {
    "signal": ("Speaker feeds (channel i = speaker i)", "A multichannel signal, one channel per speaker (up to 128)."),
    "get": ("Output all measurements", "Outputs the current measurements from the right outlet (see the outlet)."),
    "reset": ("Reset", "Clears maxima, statistics and history (see the description)."),
    "int": ("Transport position in beats (control rate)", "Same as float."),
    "float": ("Transport position in beats (control rate)", "Outputs the messages at once; holds the signal outputs there when no signal is connected."),
}

# --- objects without a refpage yet (hand-written texts) ------------------------------------------------

OBJECTS = {
    "mc.syncSuite.reverb~": {
        "digest": "A reverb that lives in the speaker space: early reflections from the real geometry, a decorrelated diffuse tail on every speaker.",
        "description": (
            "The speakers are placed where they are (speaker_coords, at speaker_distance from the listener) inside a shoebox room around "
            "the listener, and each speaker feed is a source in that room. EARLY REFLECTIONS: image sources (Allen & Berkley) up to "
            "er_order, each with its true path delay after the direct sound (the dry signal itself), 1/r level relative to the direct path "
            "and the walls' absorption per band, panned (VBAP) to the speakers in its direction: a reflection off the left wall of a sound "
            "from the front right arrives from the left, when it would. LATE FIELD: a feedback delay network of 16 to 64 lines (orthogonal "
            "mixing, delays around the room's mean free path), each line with a three-band decay that gives exactly rt60 low / mid / high, "
            "and a gentle delay modulation against ringing; every speaker reads it through its own orthogonal vector, so the tails are "
            "mutually uncorrelated and the field is diffuse around the listener. ONE ROOM: the wall absorption comes from the rt60 (Sabine), "
            "so early reflections and tail describe the same room, and the late level is calibrated to the diffuse field of that room at "
            "the speaker distance (reverberant / direct energy = 16 pi r^2 / A); er and late trim it. LFE channels pass dry. No latency. "
            "Display: room (the lattice of mirrored rooms with the image sources; click a speaker to see only its reflections), echogram "
            "(when each reflection reaches each speaker, colour = order, dashed = late onset), decay (rt60 per band), wet meters (early / "
            "late per speaker), room data (volume, mean free path, absorption, reverberant / direct, onset). CPU: about 1.2 % of a core for "
            "8 speakers, 3.6 % for 32 (48 kHz, order 3)."),
        "tags": ["Reverb", "Spatialization", "MSP"],
        "outlets": [("multichannelsignal", "Dry + reverb per speaker (same channels as the input)"),
                    ("list", "Measurements: room, absorption, late_to_direct, onset, early, late")],
        "attr_docs": {
            "room": "Width (x, left-right), depth (y, front-back) and height (z) in metres, 2 to 80. The listener is at the centre, at ear_height.",
            "speaker_distance": "Where the speakers are, around the listener (m). Sets the direct path every reflection is compared with, and the reverberant / direct balance (farther = more reverb).",
            "ear_height": "Listener's ear height above the floor (m): places the floor and ceiling reflections.",
            "rt60": "Reverberation time (s) in the low, mid and high bands (a single value = all three). Sets the late decay and, through Sabine's formula, the absorption of the walls.",
            "crossovers": "Where low meets mid and mid meets high (Hz), for the decay and the wall absorption.",
            "er_order": "Highest order of the image sources: 0 = no early reflections, 1 = the six walls, up to 4 (129 images per speaker).",
            "predelay": "Extra delay (ms) before everything reverberant, on top of the geometry's own.",
            "er": "Early reflections against their physical level (dB).",
            "late": "Late field against its physical level (dB).",
            "wet": "Reverb (early + late) level (dB).",
            "dry": "Dry signal level (dB); -120 or less = off (reverb only, e.g. on a send).",
            "diffusion": "Allpass diffusion of the signal entering the late field (0..1): smoother onset at higher values.",
            "modulation": "Slow delay modulation inside the network (0..1): prevents metallic ringing; 0 = static.",
            "freeze": "1: the tail sustains indefinitely and nothing new enters it.",
            "lines": "Size of the delay network: auto (16, or more for more than 16 speakers), 16, 32, 64. Changing it restarts the tail.",
            "select": "Speaker whose image sources and reflections are shown (0 = all). Also by clicking a speaker in the room panel.",
        },
        "method_docs": {"get": ("Output the room and levels", "room <volume m3> <surface m2> <mean free path ms>, absorption <low mid high>, late_to_direct <dB>, onset <ms>, early <dB per channel>, late <dB per channel>.")},
        "seealso": ["mc.syncSuite.decorrelator~", "mc.syncSuite.analyzer~", "syncSuite.nodes"],
    },
    "mc.syncSuite.decorrelator~": {
        "digest": "Decorrelates the channels of a layout (or spreads one input over N) without colouring them.",
        "description": (
            "Each channel runs its own cascade of six Schroeder allpass sections (random prime delays up to length, gains +-0.55 with random "
            "signs, from seed and the channel number). An allpass has an exactly flat magnitude response: nothing is coloured, the channels "
            "only differ in phase, so their mutual correlation falls (|r| < 0.1 between 16 channels of white noise at the default 10 ms; "
            "energy kept exactly). Uses: a mono source spread over many speakers without comb filtering and without collapsing into a "
            "phantom image (one input + @channels N), a correlated stem made diffuse, an upmix. TRANSIENTS: a fast / slow envelope detector "
            "briefly returns each channel to the dry signal on attacks (transient = sensitivity), so they stay sharp and in the same place "
            "on every speaker. AMOUNT blends dry and decorrelated at constant energy. Parameter changes run the old and the new cascades side "
            "by side and crossfade over 50 ms. No latency. Display: correlation matrix before and after (cyan negative, pink positive), mean "
            "|r| of all pairs, and every channel's impulse response. CPU: about 0.02 % of a core per channel."),
        "tags": ["Spatialization", "MSP"],
        "outlets": [("multichannelsignal", "Decorrelated channels (as many as the input, or @channels)"),
                    ("list", "Measurements: mean_abs <in out>, matrix <output correlation, C x C>")],
        "attr_docs": {
            "amount": "0 = dry (bit for bit), 1 = fully decorrelated; in between, constant energy.",
            "length": "Longest allpass delay (ms, 1..50): longer = lower correlation, more time smearing. Default 10.",
            "transient": "Keep attacks dry (0 = off, 1 = most sensitive).",
            "seed": "Random seed of the cascades: the same seed always gives the same filters.",
            "channels": "Output channels: 0 = as many as the input. With one input channel and channels N, the input is spread over N decorrelated outputs.",
            "window": "Correlation display window (ms).",
        },
        "method_docs": {"get": ("Output the correlation", "mean_abs <input> <output> (mean |r| over all pairs), matrix <C x C output correlation>.")},
        "seealso": ["mc.syncSuite.correlation~", "mc.syncSuite.reverb~", "syncSuite.nodes"],
    },
    "mc.syncSuite.leveller~": {
        "digest": "Slow loudness leveller for speaker layouts: one transparent gain towards a BS.1770 target.",
        "description": (
            "A slow gain rider that brings the programme to a loudness target. Measurement: ITU-R BS.1770-4 over the whole layout "
            "(K-weighting, the 1.41 surround weight for speakers at 60..120 degrees, LFE excluded), momentary (400 ms) or short-term (3 s), "
            "every 100 ms. ONE GAIN FOR EVERY CHANNEL: levels between speakers, and the image, never change. The gain moves towards target - "
            "loudness at most up / down dB per second, within +max_boost / -max_cut; below the gate (target + gate) it holds, so silence and "
            "pauses are not pumped up; inside the tolerance it does not move. No lookahead, no latency, no compression: a slow fader. The gain "
            "applied is exactly the gain metered. Display: the last minute of input and output loudness against the target (cyan) and the gate "
            "(dashed), gated stretches shaded, the gain underneath (pink = boost, cyan = cut), IN / OUT / GAIN and the state (LEVELLING, GATED, "
            "FROZEN). Pair it with mc.syncSuite.limiter~ after it for a safe output."),
        "tags": ["Dynamics", "Loudness", "MSP"],
        "outlets": [("multichannelsignal", "Levelled speaker feeds (one gain for all)"),
                    ("list", "Measurements: loudness <in M> <in S> <out M> <out S>, gain <applied> <desired>, gated <0|1>")],
        "attr_docs": {
            "target": "Loudness target (LUFS). -23 = EBU R128 broadcast, -16 / -14 = streaming.",
            "window": "What the gain follows: momentary (400 ms, faster) or short (short-term, 3 s, default).",
            "max_boost": "Most the gain can go up (dB).",
            "max_cut": "Most the gain can go down (dB).",
            "up": "Fastest rise (dB per second).",
            "down": "Fastest fall (dB per second).",
            "gate": "Below target + gate (LU) the gain holds (default -20: with target -23, below -43 LUFS).",
            "tolerance": "The gain does not move for deviations inside +- tolerance (LU).",
            "loudness_weights": "bs1770: 1.41 for speakers at 60..120 degrees (with speaker_coords), 1 elsewhere; flat: 1 for every non-LFE channel.",
            "freeze": "1: the gain holds where it is.",
        },
        "method_docs": {
            "get": ("Output the loudness and the gain", "loudness <in M> <in S> <out M> <out S> (LUFS), gain <applied> <desired> (dB), gated <0|1>."),
            "reset": ("Gain back to 0 dB", "The gain returns to 0 dB at once (at the next audio block)."),
        },
        "seealso": ["mc.syncSuite.analyzer~", "mc.syncSuite.limiter~", "mc.syncSuite.compressor~"],
    },
    "mc.syncSuite.correlation~": {
        "digest": "Inter-channel correlation of a speaker layout: matrix, layout ring, fold-down build-up / cancellation, pair scope.",
        "description": (
            "Measures how the channels of a layout relate, per 20 ms frame, over a window (default 300 ms), broadband or in low (< 250 Hz), "
            "mid and high (> 4 kHz) bands (Linkwitz-Riley). MATRIX: correlation r of every pair (-1 cyan .. 0 dark .. +1 pink; click a cell to "
            "scope that pair). RING: the layout, adjacent pairs drawn in their correlation, each speaker in its mono compatibility (its "
            "correlation with the sum of all the others: negative = it cancels against the rest). FOLD: what happens when the layout is folded "
            "down: energy of the stereo fold (as mc.syncSuite.virtualspeakers~) L and R and of the mono sum, against the sum of the folded "
            "channels' energies. 0 dB = the channels add as uncorrelated signals; above (acid yellow) they add coherently: level build-up and "
            "comb filtering wherever their delays differ; below (cyan) they cancel. SCOPE: goniometer of the selected pair (vertical = in "
            "phase, horizontal = difference). Analysis only; no audio output. CPU with bands: about 0.2 % of a core for 8 channels, 1.4 % for 32."),
        "tags": ["Analysis", "Spatialization", "MSP"],
        "outlets": [("list", "Measurements: matrix <C x C>, mono <per channel>, fold <L R M dB>, mean_abs")],
        "attr_docs": {
            "window": "Measurement window (ms, 20..2400).",
            "bands": "1 (default): also measure low / mid / high; 0: broadband only (cheaper).",
            "band": "Which band the display shows and the outlet reports: broad, low, mid, high.",
            "pair": "The two channels in the scope (1-based). Also by clicking the matrix.",
        },
        "method_docs": {"get": ("Output the measurements", "matrix <C x C correlations>, mono <per channel>, fold <L R M dB>, mean_abs <mean |r|>, for the band shown.")},
        "seealso": ["mc.syncSuite.decorrelator~", "mc.syncSuite.analyzer~", "mc.syncSuite.virtualspeakers~"],
    },
}

# --- extraction ------------------------------------------------------------------------------------------

def extract(path, defines):
    src = preprocess(open(path).read(), defines)
    attrs = {}   # name -> dict
    order = []
    category = None

    def ensure(name):
        if name not in attrs:
            attrs[name] = {"type": "float64", "size": 1, "label": "", "default": "", "enum": None, "category": category}
            order.append(name)
        return attrs[name]

    for line in src.splitlines():
        s = line.strip()
        m = re.search(r'CLASS_STICKY_CATEGORY\(c,\s*0,\s*"([^"]+)"\)', s)
        if m:
            category = m.group(1)
            continue
        if "CLASS_STICKY_CATEGORY_CLEAR" in s:
            category = None
            continue
        for macro, names in {"MCT_LAYOUT_ATTRS": ["speaker_coords", "speaker_elevations", "lfe"],
                             "MCT_UI_ATTRS": ["view", "bypass_ui", "output", "interval"], "MCT_NO_UI_ATTR": ["no_ui"],
                             "MCT_COLOR_ATTRS": ["bgcolor", "panelcolor", "textcolor", "gridcolor", "color", "alarmcolor"]}.items():
            if re.match(r"%s\(" % macro, s):
                for n in names:
                    a = ensure(n)
                    t, size, label, default, cat, _ = COMMON_ATTRS[n]
                    a.update(type=t, size=size, label=label, default=default, category=cat)
                if macro == "MCT_UI_ATTRS":
                    em = re.search(r'MCT_UI_ATTRS\(\w+,\s*\w+,\s*"([^"]+)",\s*"([^"]*)"', s)
                    if em:
                        attrs["view"]["enum"] = em.group(1).split()
                        attrs["view"]["default"] = em.group(2)
        m = re.search(r'CLASS_ATTR_(DOUBLE|LONG|SYM|RGBA)(_VARSIZE|_ARRAY)?\(c,\s*"(\w+)"(.*)\)', s)
        if m:
            a = ensure(m.group(3))
            kind = m.group(1)
            a["type"] = {"DOUBLE": "float64", "LONG": "int", "SYM": "symbol", "RGBA": "float64"}[kind]
            a["size"] = 4 if kind == "RGBA" else 1
            if m.group(2):
                sz = m.group(4).split(",")[-1].strip()
                a["size"] = {"kMaxChannels": 128, "kMaxBands": 6, "kMaxPoints": 128, "kMaxPoints * 3": 384, "kMaxBands - 1": 5}.get(sz, int(sz) if sz.isdigit() else 16)
            if a["category"] is None:
                a["category"] = category
        m = re.search(r'\b(ATTR_D|ATTR_L|ATTR_LIST|REV_D|REV_L|DEC_D|LEV_D)\("(\w+)",\s*\w+,\s*"([^"]*)",\s*"([^"]*)"\)', s)
        if m:
            a = ensure(m.group(2))
            a["type"] = "int" if m.group(1) in ("ATTR_L", "REV_L") else "float64"
            a["size"] = 6 if m.group(1) == "ATTR_LIST" else 1
            a["label"], a["default"] = m.group(3), m.group(4)
            a["category"] = category
        m = re.search(r'CLASS_ATTR_LABEL\(c,\s*"(\w+)",\s*0,\s*"([^"]*)"\)', s)
        if m:
            ensure(m.group(1))["label"] = m.group(2)
        m = re.search(r'CLASS_ATTR_STYLE_LABEL\(c,\s*"(\w+)",\s*0,\s*"[^"]*",\s*"([^"]*)"\)', s)
        if m:
            ensure(m.group(1))["label"] = m.group(2)
        m = re.search(r'CLASS_ATTR_ENUMINDEX\(c,\s*"(\w+)",\s*0,\s*"([^"]*)"\)', s)
        if m:
            ensure(m.group(1))["enum"] = m.group(2).split()
        m = re.search(r'CLASS_ATTR_(?:DEFAULT|DEFAULT_SAVE|DEFAULT_SAVE_PAINT|DEFAULT_PAINT|DEFAULTNAME_SAVE_PAINT)\(c,\s*"(\w+)",\s*0,\s*(?:"([^"]*)"|(\w+))\)', s)
        if m and m.group(1) != "patching_rect":
            ensure(m.group(1))["default"] = m.group(2) if m.group(2) is not None else ""
        m = re.search(r'CLASS_ATTR_CATEGORY\(c,\s*"(\w+)",\s*0,\s*"([^"]*)"\)', s)
        if m:
            ensure(m.group(1))["category"] = m.group(2)
    attrs.pop("patching_rect", None)
    order = [o for o in order if o in attrs]
    methods = []
    for name, kind in re.findall(r'class_addmethod\(\s*c\s*,\s*\(method\)\s*\w+\s*,\s*"([^"]+)"\s*,\s*([A-Z_0-9]+)', src):
        if kind != "A_CANT" and name not in methods:
            methods.append((name, kind))
    if re.search(r'"dsp64"', src):
        methods.insert(0, ("signal", "0"))
    return order, attrs, methods

# --- existing refpage texts ------------------------------------------------------------------------------

def old_page(name):
    p = os.path.join(REF, name + ".maxref.xml")
    if not os.path.exists(p):
        return None
    return ET.parse(p).getroot()


def text_of(el, tag):
    t = el.find(tag) if el is not None else None
    return " ".join((t.text or "").split()) if t is not None and t.text else ""


def xml_block(el):
    """An existing element re-serialized (inlets, outlets, arguments)."""
    return ET.tostring(el, encoding="unicode").strip()

# --- writing ------------------------------------------------------------------------------------------------

ARG_OF = {"A_FLOAT": ("value", "float"), "A_LONG": ("value", "int"), "A_DEFLONG": ("value", "int"), "A_DEFFLOAT": ("value", "float"),
          "A_SYM": ("value", "symbol"), "A_DEFSYM": ("value", "symbol")}


def write(name, order, attrs, methods):
    old = old_page(name)
    info = OBJECTS.get(name, {})
    digest = text_of(old, "digest") or info.get("digest", "")
    desc = text_of(old, "description") or info.get("description", "")
    old_attr = {a.get("name"): a for a in old.iter("attribute")} if old is not None else {}
    old_meth = {m.get("name"): m for m in old.iter("method")} if old is not None else {}
    out = ['<?xml version="1.0" encoding="utf-8" standalone="yes"?>', '<?xml-stylesheet href="./c74ref.xsl" type="text/xsl"?>', "",
           '<c74object name="%s">' % escape(name), "", "    <digest>", "        " + escape(digest), "    </digest>", "",
           "    <description>", "        " + escape(desc), "    </description>", "", "    <!--METADATA-->", "    <metadatalist>",
           '        <metadata name="author">Agustin Issidoro</metadata>', '        <metadata name="tag">SyncSuite</metadata>']
    tags = info.get("tags") or ([m.text for m in old.iter("metadata") if m.get("name") == "tag" and m.text != "SyncSuite"] if old is not None else ["MSP"])
    for t in tags:
        out.append('        <metadata name="tag">%s</metadata>' % escape(t))
    out += ["    </metadatalist>", ""]

    if old is not None and old.find("objarglist") is not None and len(old.find("objarglist")):
        out += ["    <!--ARGUMENTS-->", "    " + xml_block(old.find("objarglist")), ""]

    # messages (and the old entries documenting an attribute as a message, e.g. with a dialog when sent alone)
    methods = list(methods) + [(m, "0") for m in old_meth if m in attrs and m not in [n for n, _ in methods]]
    out += ["    <!--MESSAGES-->", "    <methodlist>"]
    for mname, kind in methods:
        om = old_meth.get(mname)
        d, dd = (text_of(om, "digest"), text_of(om, "description")) if om is not None else ("", "")
        if not d:
            d, dd2 = info.get("method_docs", {}).get(mname, COMMON_METHODS.get(mname, (mname, "")))
            dd = dd or dd2
        out.append('        <method name="%s">' % escape(mname))
        if om is not None and om.find("arglist") is not None:
            out.append("            " + xml_block(om.find("arglist")))
        elif kind in ARG_OF:
            n, t = ARG_OF[kind]
            out.append('            <arglist><arg name="%s" optional="%d" type="%s" /></arglist>' % (n, 1 if "DEF" in kind else 0, t))
        else:
            out.append("            <arglist />")
        out += ["            <digest>%s</digest>" % escape(d), "            <description>%s</description>" % escape(dd), "        </method>"]
    out += ["    </methodlist>", ""]

    # attributes
    out += ["    <!--ATTRIBUTES-->", "    <attributelist>"]
    for an in order:
        a = attrs[an]
        oa = old_attr.get(an)
        d = a["label"] or (text_of(oa, "digest") if oa is not None else "") or an
        dd = (text_of(oa, "description") if oa is not None else "") or info.get("attr_docs", {}).get(an) or (COMMON_ATTRS[an][5] if an in COMMON_ATTRS else "")
        extra = []
        if a["enum"]:
            extra.append("Values: " + ", ".join("%d = %s" % (i, v) for i, v in enumerate(a["enum"])) + " (a number or the name).")
        if a["default"] and a["default"] not in dd:
            extra.append("Default: %s." % a["default"].replace('"', ""))
        full = " ".join([dd] + [e for e in extra if e not in dd]).strip()
        size = a["size"]
        out.append('        <attribute name="%s" get="1" set="1" type="%s" size="%d">' % (escape(an), a["type"], size))
        out.append("            <digest>%s</digest>" % escape(d))
        out.append("            <description>%s</description>" % escape(full))
        sub = []
        if a["category"]:
            sub.append('                <attribute name="category" get="1" set="1" type="symbol" size="1" value="%s" />' % escape(a["category"]))
        if a["label"]:
            sub.append('                <attribute name="label" get="1" set="1" type="symbol" size="1" value="%s" />' % escape(a["label"]))
        if an.endswith("color"):
            sub.append('                <attribute name="style" get="1" set="1" type="symbol" size="1" value="rgba" />')
        if a["enum"]:
            sub.append('                <attribute name="style" get="1" set="1" type="symbol" size="1" value="enumindex" />')
            sub.append('                <attribute name="enumvals" get="1" set="1" type="atom" size="%d">' % len(a["enum"]))
            sub.append("                    <enumlist>")
            for v in a["enum"]:
                sub.append('                        <enum name="%s"><digest>%s</digest></enum>' % (escape(v), escape(v)))
            sub.append("                    </enumlist>")
            sub.append("                </attribute>")
        if sub:
            out += ["            <attributelist>"] + sub + ["            </attributelist>"]
        out.append("        </attribute>")
    out += ["    </attributelist>", ""]

    # inlets / outlets
    if old is not None and old.find("inletlist") is not None:
        out += ["    <!--INLETS-->", "    " + xml_block(old.find("inletlist")), ""]
    else:
        out += ["    <!--INLETS-->", "    <inletlist>", '        <inlet id="0" type="multichannelsignal">',
                "            <digest>Speaker feeds (channel i = speaker i) and messages</digest>", "        </inlet>", "    </inletlist>", ""]
    if old is not None and old.find("outletlist") is not None:
        out += ["    <!--OUTLETS-->", "    " + xml_block(old.find("outletlist")), ""]
    else:
        out += ["    <!--OUTLETS-->", "    <outletlist>"]
        for i, (t, d) in enumerate(info.get("outlets", [])):
            out += ['        <outlet id="%d" type="%s">' % (i, t), "            <digest>%s</digest>" % escape(d), "        </outlet>"]
        out += ["    </outletlist>", ""]
    seealso = info.get("seealso") or ([s.get("name") for s in old.iter("seealso")] if old is not None else [])
    out += ["    <!--SEEALSO-->", "    <seealsolist>"] + ['        <seealso name="%s" />' % escape(s) for s in seealso] + ["    </seealsolist>", "", "</c74object>", ""]
    xml = "\n".join(out)
    ET.fromstring(xml.split("\n", 2)[2])   # well-formed
    open(os.path.join(REF, name + ".maxref.xml"), "w").write(xml)


def main():
    for name, src, defs in CPP_OBJECTS:
        order, attrs, methods = extract(os.path.join(GITHUB, src), defs)
        write(name, order, attrs, methods)
        print("%-32s %2d attributes, %2d messages" % (name, len(order), len(methods)))


if __name__ == "__main__":
    main()
