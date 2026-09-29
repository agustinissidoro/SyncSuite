#!/usr/bin/env python3
"""check_docs.py - keep the syncSuite reference pages in step with the code.

Max builds its autocompletion (object names in the object box, then messages
and @attributes after the name) and its reference / Object Explorer entries
from docs/refpages/*.maxref.xml. This script extracts the real interface of
every object and compares it with its refpage:

  C++ externals   attributes and messages from the sources in the sibling
                  *-package folders (DYN_KIND variants evaluated)
  JavaScript      functions exposed as messages (v8 / v8ui), Node for Max
                  handlers (Max.addHandler)
  abstractions    patcherargs attributes of the patchers/*.maxpat files

It reports, per object: attributes / messages in the code but not in the
refpage (missing: no autocompletion, no reference), in the refpage but not in
the code (stale), refpage entries without a digest, and objects without a
refpage or help file. Exit status 1 when anything is missing or stale.

  python3 tools/check_docs.py            (from the syncSuite folder)
"""
import json
import os
import re
import sys
import xml.etree.ElementTree as ET

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
PKG = os.path.join(REPO, "max-package")
GITHUB = os.path.dirname(REPO)
REF = os.path.join(PKG, "docs", "refpages")

# --- C++ ----------------------------------------------------------------------------------

MACRO_ATTRS = {
    "MCT_LAYOUT_ATTRS": ["speaker_coords", "speaker_elevations", "lfe"],
    "MCT_UI_ATTRS": ["view", "bypass_ui", "output", "interval"],
    "MCT_NO_UI_ATTR": ["no_ui"],
    "MCT_COLOR_ATTRS": ["bgcolor", "panelcolor", "textcolor", "gridcolor", "color", "alarmcolor"],
}
ATTR_CALL = re.compile(r'\b(?:CLASS_ATTR_(?:DOUBLE|LONG|SYM|RGBA|CHAR|FLOAT|ATOM|OBJ)(?:_VARSIZE|_ARRAY)?|'
                       r'ATTR_D|ATTR_L|ATTR_LIST|REV_D|REV_L|DEC_D|LEV_D)\(\s*(?:c\s*,\s*)?"([A-Za-z_0-9]+)"')
METHOD_CALL = re.compile(r'class_addmethod\(\s*c\s*,\s*\(method\)\s*\w+\s*,\s*"([^"]+)"\s*,\s*([A-Z_0-9]+)')
# Max calls these itself (v8 / v8ui): not messages for the user
JS_CALLBACKS = {"paint", "onclick", "ondblclick", "ondrag", "onidle", "onidleout", "onresize", "getvalueof", "setvalueof",
                "save", "loadbang", "notifydeleted", "anything", "msg_int", "msg_float", "list", "bang"}


def preprocess(src, defines):
    """Keeps the lines active for the given #define values (#if / #elif / #else / #endif on simple expressions)."""
    out, stack = [], []   # stack of (taking, taken_any)
    macros = dict(defines)

    def ev(expr):
        e = expr.strip()
        e = re.sub(r"\bdefined\s*\(?\s*(\w+)\s*\)?", lambda m: "1" if m.group(1) in macros else "0", e)
        e = re.sub(r"\b[A-Z_][A-Z_0-9]*\b", lambda m: str(macros.get(m.group(0), 0)), e)
        e = e.replace("&&", " and ").replace("||", " or ").replace("!", " not ").replace(" not =", "!=")
        try:
            return bool(eval(e, {}, {}))
        except Exception:
            return False

    for line in src.splitlines():
        s = line.strip()
        active = all(t for t, _ in stack)
        m = re.match(r"#\s*(if|ifdef|ifndef|elif|else|endif|define)\b(.*)", s)
        if m:
            kw, rest = m.group(1), m.group(2)
            if kw in ("if", "ifdef", "ifndef"):
                cond = ev(rest) if kw == "if" else ((rest.strip() in macros) == (kw == "ifdef"))
                stack.append((cond, cond))
            elif kw == "elif":
                t, any_ = stack.pop()
                cond = (not any_) and ev(rest)
                stack.append((cond, any_ or cond))
            elif kw == "else":
                t, any_ = stack.pop()
                stack.append((not any_, True))
            elif kw == "endif":
                stack.pop()
            elif kw == "define" and active:
                dm = re.match(r"\s*(\w+)\s+(.+)", rest)
                if dm and dm.group(1) not in macros:
                    val = dm.group(2).strip()
                    try:
                        macros[dm.group(1)] = int(ev(val)) if re.search(r"[=<>!]", val) else int(val)
                    except ValueError:
                        macros[dm.group(1)] = val
            continue
        if active:
            out.append(line)
    return "\n".join(out)


def cpp_interface(path, defines=None):
    src = preprocess(open(path).read(), defines or {})
    attrs = set(ATTR_CALL.findall(src))
    for macro, names in MACRO_ATTRS.items():
        if re.search(r"\b%s\(" % macro, src):
            attrs.update(names)
    attrs.discard("patching_rect")
    methods = set()
    for name, kind in METHOD_CALL.findall(src):
        if kind != "A_CANT":
            methods.add(name)
    # A_CANT dsp64: an MSP object -> the "signal" message
    if re.search(r'"dsp64"', src):
        methods.add("signal")
    return attrs, methods


CPP_OBJECTS = [
    # name, source, defines
    ("mc.syncSuite.analyzer~", "syncSuite.analyzer-package/source/common/analyzer_max.cpp", {}),
    ("mc.syncSuite.limiter~", "syncSuite.dynamics-package/source/common/dyn_max.cpp", {"DYN_KIND": 0}),
    ("mc.syncSuite.compressor~", "syncSuite.dynamics-package/source/common/dyn_max.cpp", {"DYN_KIND": 1}),
    ("mc.syncSuite.multiband~", "syncSuite.dynamics-package/source/common/dyn_max.cpp", {"DYN_KIND": 2}),
    ("syncSuite.trajectory~", "syncSuite.trajectory-package/source/common/traj_max.cpp", {}),
    ("mc.syncSuite.reverb~", "syncSuite.mctools-package/source/common/reverb_max.cpp", {}),
    ("mc.syncSuite.decorrelator~", "syncSuite.mctools-package/source/common/decorr_max.cpp", {}),
    ("mc.syncSuite.leveller~", "syncSuite.mctools-package/source/common/level_max.cpp", {}),
    ("mc.syncSuite.correlation~", "syncSuite.mctools-package/source/common/corr_max.cpp", {}),
    ("syncSuite.virtualspeakers~", "syncSuite.virtualspeakers-package/source/common/virtualspeakers_max.cpp", {"VS_MC": 0}),
    ("mc.syncSuite.virtualspeakers~", "syncSuite.virtualspeakers-package/source/common/virtualspeakers_max.cpp", {"VS_MC": 1}),
]

# --- JavaScript ----------------------------------------------------------------------------------

def js_v8_messages(path):
    """Global functions of a [v8] / [v8ui] script are messages unless marked .local = 1."""
    src = open(path).read()
    funcs = set(re.findall(r"^function\s+([A-Za-z_]\w*)\s*\(", src, re.M))
    local = set(re.findall(r"^\s*([A-Za-z_]\w*)\.local\s*=\s*1", src, re.M))
    for block in re.findall(r"\[([A-Za-z_0-9,\s]+)\]\.forEach\(\s*\w+\s*=>\s*\{?\s*\w+\.local\s*=\s*1", src):
        local.update(n.strip() for n in block.split(",") if n.strip())
    return funcs - local, local


def js_n4m_messages(path):
    src = open(path).read()
    names = set(re.findall(r"""addHandler\(\s*['"]([^'"]+)['"]""", src))
    # handlers registered in a loop over a literal list: [...].forEach(name => Max.addHandler(name, ...))
    for block in re.findall(r"\[([^\]]*)\]\s*\.forEach\(\s*\(?\s*(\w+)[^)]*\)?\s*=>\s*\{?\s*Max\.addHandler\(\s*\2", src):
        names.update(re.findall(r"""['"]([^'"]+)['"]""", block[0]))
    for arr in re.findall(r"(?:const|let|var)\s+\w+\s*=\s*\[([^\]]*)\];[^;]*?for\s*\(", src, re.S):
        pass
    return names

# --- abstractions -----------------------------------------------------------------------------------

def patcher_attrs(path):
    """@attributes read with patcherargs (the attribute names that patcherargs routes)."""
    def walk(p, out):
        for b in p.get("boxes", []):
            bb = b["box"]
            t = bb.get("text", "") or ""
            if t.startswith("patcherargs"):
                out.update(re.findall(r"@(\w+)", t))
            if "patcher" in bb:
                walk(bb["patcher"], out)
    out = set()
    walk(json.load(open(path))["patcher"], out)
    return out

# --- refpages ------------------------------------------------------------------------------------------

def refpage(name):
    p = os.path.join(REF, name + ".maxref.xml")
    if not os.path.exists(p):
        return None
    root = ET.parse(p).getroot()
    al, ml = root.find("attributelist"), root.find("methodlist")   # top level only (not the Inspector sub-attributes)
    attrs = {a.get("name"): (a.findtext("digest") or "").strip() for a in (al.findall("attribute") if al is not None else [])}
    methods = {m.get("name"): (m.findtext("digest") or "").strip() for m in (ml.findall("method") if ml is not None else [])}
    digest = (root.findtext("digest") or "").strip()
    return {"attrs": attrs, "methods": methods, "digest": digest}


def report(name, attrs, methods, problems, loose_methods=False):
    r = refpage(name)
    if r is None:
        problems.append((name, "no refpage"))
        return
    if not r["digest"]:
        problems.append((name, "refpage has no digest (the autocompletion line)"))
    for a in sorted(attrs - set(r["attrs"])):
        problems.append((name, "attribute missing from refpage: %s" % a))
    for a in sorted(set(r["attrs"]) - attrs):
        problems.append((name, "attribute in refpage but not in the code: %s" % a))
    for m in sorted(methods - set(r["methods"])):
        problems.append((name, "message missing from refpage: %s" % m))
    if not loose_methods:
        for m in sorted(set(r["methods"]) - methods - attrs):   # an attribute is also a message
            problems.append((name, "message in refpage but not in the code: %s" % m))
    for k, d in list(r["attrs"].items()) + list(r["methods"].items()):
        if not d:
            problems.append((name, "no digest for: %s" % k))
    if not os.path.exists(os.path.join(PKG, "help", name + ".maxhelp")):
        problems.append((name, "no help file"))


def main():
    problems = []
    for name, src, defs in CPP_OBJECTS:
        path = os.path.join(GITHUB, src)
        if not os.path.exists(path):
            problems.append((name, "source not found: %s" % src))
            continue
        a, m = cpp_interface(path, defs)
        report(name, a, m, problems)

    # syncSuite.nodes (v8ui): public messages = functions not marked local
    pub, local = js_v8_messages(os.path.join(PKG, "js", "syncSuite.nodes.js"))
    report("syncSuite.nodes", set(), pub - JS_CALLBACKS, problems)

    # Node for Max objects
    for name, js in [("syncSuite.netscan", "syncSuite.netscan.js"), ("syncSuite.score.server", "syncSuite.score.server.js")]:
        msgs = js_n4m_messages(os.path.join(PKG, "js", js))
        report(name, patcher_attrs(os.path.join(PKG, "patchers", name + ".maxpat")), msgs, problems, loose_methods=True)

    # abstractions: attributes only (their messages are routed inside the patchers; checked by hand)
    for name in ["syncSuite.scoreplayer", "syncSuite.video.context", "syncSuite.video.source", "syncSuite.video.subs"]:
        attrs = patcher_attrs(os.path.join(PKG, "patchers", name + ".maxpat"))
        report(name, attrs, set(), problems, loose_methods=True)

    # jit.pdfmatrix: source elsewhere, only presence
    if refpage("jit.pdfmatrix") is None:
        problems.append(("jit.pdfmatrix", "no refpage"))

    # package metadata shown in the Package Manager
    info = json.load(open(os.path.join(PKG, "package-info.json")))
    for k in ("displayname", "author", "description", "website"):
        if not info.get(k):
            problems.append(("package-info.json", "empty: %s" % k))

    width = max((len(n) for n, _ in problems), default=0)
    for n, p in problems:
        print("%-*s  %s" % (width, n, p))
    print("%d problem(s)" % len(problems))
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
