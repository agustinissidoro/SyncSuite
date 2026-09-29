/**
 * syncSuite.nodes.js  (v8ui)
 *
 * A multi-source take on [nodes] with built-in panning. Speakers are nodes,
 * sources are knobs that move around the field. Gains (amplitude, constant
 * power) are output only on request with get_gains; smoothing is left to
 * audio objects. Each source picks its own algorithm: 0 = VBAP (default),
 * 1 = DBAP.
 *
 * Type "syncSuite.nodes" in an object box (mapped to this v8ui by
 * init/syncSuite-objectmappings.txt); Alt-click it for the help patch,
 * reference: docs/refpages/syncSuite.nodes.maxref.xml. Starts with 8
 * speakers and 4 sources; as a plain [v8ui syncSuite.nodes.js <speakers>
 * <sources>] the counts can also be given as arguments.
 *
 * Space: a circular field, listener at the centre, speakers on its perimeter
 * by default. Positions are azimuth + distance: distance 0 = centre, 1 = the
 * perimeter (the speaker circle); nothing can go outside it. Front = up.
 * (source_xy uses x/y 0..1 with the centre at 0.5 0.5, y down.)
 * Indices are 1-based everywhere. Speaker i is always the i-th value of the
 * "speaker_coords" list, and gain i is always for that speaker, whatever the
 * layout: the list is never re-ordered (VBAP sorts by azimuth only
 * internally, to find neighbouring pairs).
 * Azimuth: degrees, 0 = front (up), clockwise positive.
 *
 * VBAP (Pulkki 1997, 2D pairwise; spread = MDAP, Pulkki 1999)
 *   Speakers are sorted by azimuth around the centre; adjacent speakers form
 *   pairs and g = p^T L^-1, normalized to unit power. Source distance is
 *   ignored, only its azimuth counts. source_spread (0..1) pans virtual
 *   sources 1 deg apart all around the circle, weighted by a smooth bell
 *   centred on the source, w = ((1 + cos a) / 2)^p, sums them and
 *   renormalizes (a weighted MDAP). The bell halves at 180 deg x spread^focus
 *   (spread_focus, default 1.6), so
 *   levels fall off smoothly from the source's direction: 0 = point (plain
 *   VBAP), 0.5 = the speakers 45 deg away are 3 dB below the one it points at,
 *   1 = flat. Spread 1 = every speaker receives the
 *   same level on any layout: near the top the gains blend, at constant
 *   power, into equal gains (weight spread^8).
 *   Extensions (not in Pulkki), all constant power:
 *   - pairs wider than 170 deg, where VBAP breaks down (e.g. stereo L/R at
 *     +-90), use a sin/cos crossfade across the gap;
 *   - speakers at the same azimuth act as one group sharing the gain
 *     equally (g / sqrt(m));
 *   - vbap_center_blend 1 (default): inside the speaker ring the gains blend
 *     towards all-speakers-equal, g_i = sqrt(t g_i^2 + (1 - t) / N) with
 *     t = r / r_ring, so the centre is omni and crossing it does not jump.
 *   Problematic layouts (pairs wider than 170 deg, shared azimuths, a
 *   speaker at the centre, unequal distances, fewer than 2 speakers) are
 *   reported once in the Max console, with what the code does about them.
 *
 * DBAP (Lossius, Baltazar, de la Hogue, ICMC 2009, rev. 2011)
 *   d_i = sqrt(dx^2 + dy^2 + r_s^2)          r_s = blur * sigma
 *   v_i = k w_i / d_i^a                        a = R / (20 log10 2)
 *   k   = 1 / sqrt(sum w_i^2 / d_i^(2a))       => sum v_i^2 = 1
 *   R = dbap_rolloff (dB per doubling, default 6), w_i = speaker_weight
 *   (default 1), sigma = sqrt(sum |p_i - mean|^2 / (N - 1)) of the speaker
 *   positions (blur normalization as in Jamoma's j.dbap). With blur 0 and the
 *   source exactly on a speaker the exact limit is used (that speaker = 1).
 *   dbap_hull 1 (default): a source outside the convex hull of the speakers
 *   is projected onto it (paper, 2.3) and its distance to the hull is
 *   reported as hull_distance.
 *
 * Mono / stereo sources (sources_mode, default all mono): a stereo source has
 * two channels, L and R, placed at azimuth -/+ width/2 around the source's
 * centre, at the same distance (width as seen from the listener). The width
 * grows with distance: width = maximum width x distance, so a source on the
 * perimeter is at the full width and L and R meet at the centre. The maximum
 * is stereo_width (global, default 60 deg) or the source's own
 * source_stereo_width; the last one sent wins (stereo_width resets every
 * source to the global value). L and R are always linked: moving either moves the
 * source. Each channel is panned on its own at unit power, with the
 * source's algorithm, spread and blur. Channel 1 = mono or L, 2 = R.
 *
 * Mirrored sources (mirror_sources a b [lr|fb|point]): moving either one
 * moves the other to the mirror position. lr (default) mirrors left/right
 * (az -> -az: one goes clockwise, the other counter-clockwise), fb mirrors
 * front/back (az -> 180 - az), point goes through the centre (az + 180).
 * Only positions are mirrored; L/R, spread, width etc. stay per source.
 *
 * Levels: gains are constant power (sum of g^2 = 1 per channel, as in VBAP
 * and DBAP), so a source on a speaker is 0 dB and at the centre of 8 speakers
 * each gets -9 dB. distance_attenuation then lowers sources inside the
 * speaker ring towards the centre (see below).
 *
 * Efficiency: nothing is computed or output on its own. Moving a source only
 * stores its position and marks it dirty; gains are computed lazily, once,
 * when get_gains asks for them (or when the UI repaints, never with
 * bypass_ui 1). Mouse edits only report positions with
 * output_source_position 1.
 *
 * Out 0 (gains):     on get_gains: <source> <channel> <g1> <g2> ... <gN>
 *                    one list per channel: mono sources -> channel 1,
 *                    stereo sources -> channel 1 (L) and 2 (R)
 * Out 1 (analysis):  on get_gains: hull_distance <source> <channel> <d>  (DBAP, dbap_hull 1)
 *                    on get_geometry (source centre), per "geometry polar|cartesian" and
 *                    "format pair|list":
 *                    pair: <source> <speaker> <az> <dist> | <dx> <dy>
 *                    list: <source> <a1> <b1> <a2> <b2> ...
 * Out 2 (state):     on get_source / dump / get_speakers, and on MOUSE edits.
 *                    Never echoed for inlet messages, so it can go to
 *                    live.dial/pattr and come back in without a loop:
 *                    source <i> <az> <dist>   (mouse: only with output_source_position 1)
 *                    source_spread <i> <0..1> source_blur <i> <v>
 *                    speaker <i> <az> <dist>
 *                    source_stereo_width <i> <deg>   (shift-drag)
 *                    source_attenuation <i> <dB>   (click, information only)
 *                    dump also: algorithm, sources_mode, mirror_sources, speaker_weight
 *                    get_speakers: speaker_coords <az1> <az2> ...
 *                                  (same message syncSuite.virtualspeakers~ takes)
 *
 * Tests: node max-package/js/test/syncSuite.nodes.test.js
 *
 * In ([i] = optional index; without it the value goes to all):
 *   speakers
 *     speaker_coords <deg1> <deg2> ...   the layout: one speaker per azimuth
 *                                     (0 = front, clockwise), on a ring
 *     speaker <i> <az> [dist]         move one speaker (distance 0..1, default 1 =
 *                                     the perimeter)
 *     speaker_azimuth | speaker_distance <i> <v>
 *     speaker_weight [i] <w>          DBAP speaker weight
 *   sources
 *     num_sources <n>
 *     sources_mode <f1> <f2> ...      one flag per source, in order: 0 = mono
 *                                     (default), 1 = stereo. "sources_mode 0 1 0 0"
 *                                     makes source 2 stereo. Sources beyond the
 *                                     list keep their mode; extra flags are ignored.
 *     source <i> <az> <dist>          azimuth (deg) + distance from the centre
 *     source_azimuth | source_distance <i> <v>
 *     source_xy <i> <x> <y>           normalized x/y
 *     (distance 0 = centre, 1 = perimeter; larger values, and x/y outside the
 *     circle, are pulled onto the perimeter keeping the azimuth)
 *     stereo_width <deg>              maximum L/R angle of stereo sources, reached at
 *                                     full distance (0..180, default 60); narrower
 *                                     towards the centre (width x distance)
 *     source_stereo_width <i> [deg]   per-source maximum, until the next stereo_width
 *                                     (which resets all sources); without a value the
 *                                     source follows stereo_width again
 *     mirror_sources <a> <b> [lr|fb|point]   link b as a's mirror (b jumps to it)
 *     mirror_sources <a>              unlink a (and its partner)
 *     mirror_sources                  unlink all
 *   panning
 *     algorithm [i] <0|1>             0 = VBAP (default), 1 = DBAP
 *     source_spread [i] <0..1>        VBAP spread: 0 = point, 0.5 = pointy with a smooth
 *                                     rolloff, 1 = all speakers equal
 *     spread_focus <v>                shape of the spread in between, for all sources
 *                                     (0.25..8, default 1.6): higher = stays pointed
 *                                     longer, lower = goes flat sooner
 *     vbap_center_blend <0|1>
 *     source_blur [i] <v>             DBAP spatial blur
 *     dbap_rolloff <dB>               dbap_hull <0|1>
 *   levels
 *     distance_attenuation <dB>       level at the centre for all sources (default 0):
 *                                     0 dB on the speaker ring, fading linearly in dB
 *                                     to <dB> at the centre; applied after panning
 *     source_distance_attenuation <i> [dB]   per-source value, until the next
 *                                     distance_attenuation (which resets all sources);
 *                                     without a value the source follows the global again
 *   output
 *     get_gains [i]                   -> out 0 (all channels of the source)
 *     get_source [i]                  -> out 2: source <i> <az> <dist>
 *     get_geometry [i]                -> out 1, per geometry polar|cartesian, format pair|list
 *     get_speakers | dump             -> out 2
 *     output_source_position <0|1>    report mouse edits on out 2 (default 0): dragging a
 *                                     source sends source <i> <az> <dist>; clicking one
 *                                     also sends source_spread (+ source_blur for DBAP),
 *                                     source_stereo_width (stereo sources) and
 *                                     source_attenuation <i> <dB> (distance
 *                                     attenuation applied now; information only);
 *                                     clicking a speaker (edit_speakers 1) sends speaker
 *   UI
 *     edit_speakers <0|1>             unlock speakers for mouse editing
 *     draw_distance | draw_spread | draw_sources | draw_speakers <0|1>
 *     draw_intensity <0|1>            per-speaker level of the selected source, in dB
 *     speaker_size <px> | source_size <px>   drawn size (defaults 14 and 16)
 *     select_source <i>               the source whose levels the speakers show
 *                                     (also set by clicking a source)
 *     bypass_ui <0|1>                 stop drawing (gains still available)
 *
 * Mouse: drag = move source (either knob of a stereo pair), cmd-drag =
 *        spread (VBAP) or blur (DBAP), shift-drag = source_stereo_width, both up/down.
 *        With edit_speakers 1: drag speaker = move.
 *        Spread is drawn as an arch in a halo around the source (thicker and
 *        brighter where more of it goes); blur as a plain halo.
 *
 * The engine section has no Max/UI dependencies, so it can be moved to a
 * UI-less [v8] object later without changes.
 */

inlets = 1;
outlets = 3;
setinletassist(0, "get_gains, speaker_coords, num_sources, sources_mode, source*, speaker*, stereo_width, mirror_sources, algorithm, dbap_*, vbap_*, get_*, draw_*, edit_speakers, bypass_ui, dump");
setoutletassist(0, "gains (get_gains): <source> <channel> <g1> ... <gN>");
setoutletassist(1, "analysis: hull_distance <source> <channel> <d> (get_gains) | geometry (get_geometry)");
setoutletassist(2, "state (get_source, get_speakers, dump, mouse edits): source <i> <az> <dist>, source_spread, source_blur, source_stereo_width, speaker <i> <az> <dist>, speaker_coords <az...>");

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

const EPS = 1e-6;
const RAD = Math.PI / 180;
const CX = 0.5;
const CY = 0.5;
const FIELD_R = 0.5;        // the field is a circle of this radius (x/y units); distance 1 = its perimeter
const SPK_RING = FIELD_R;   // speakers sit on the perimeter by default
const SRC_RING = 0.3;       // new sources: distance 0.6
const VBAP = 0;
const DBAP = 1;
const WIDE_SPAN = 170;      // deg; wider VBAP pairs use a constant-power crossfade
const VS_STEP = 1;          // deg between spread virtual sources
const MAX_BLUR = 10;
const AZ_EPS = 1e-6;        // deg; speakers closer than this share a VBAP group
const CENTRE_EPS = 1e-3;    // speakers closer than this to the centre have no direction
const DIST_TOLERANCE = 0.2; // VBAP warning when a speaker's distance is off the mean by more
const DEFAULT_STEREO_WIDTH = 60;
const DEFAULT_SPREAD_FOCUS = 1.6;         // spread curve, see spreadExponent
const MIN_SPREAD_FOCUS = 0.25;
const MAX_SPREAD_FOCUS = 8;
const MIRROR_MODES = ["lr", "fb", "point"];
const DEFAULT_ROLLOFF = 6;  // dB per doubling of distance (inverse distance law)

let spk = [];               // {x, y, weight, az}
let src = [];               // {x, y, algorithm, spread, blur, stereo, stereoWidth (null = global), mirror, mirrorMode, ch, dirty}
                            // ch: channels [{x, y, px, py, hullDist}], 1 (mono) or 2 (L, R)
let gains = [];             // per source, per channel: Float64Array(spk.length)
let dia = new Float64Array(0); // DBAP scratch: d_i^a

// layout-derived
let groups = [];            // VBAP: speakers sharing an azimuth, sorted {az, members}
let arcs = [];              // VBAP pairs of adjacent groups {a, b, start, span}, sorted by start
let rRef = SPK_RING;        // mean speaker distance from the centre
let sigma = 0;              // DBAP blur scale
let hull = [];              // DBAP convex hull, speaker indices, CCW

// algorithm settings
let dbapRolloff = DEFAULT_ROLLOFF;
let dbapA = rolloffToA(DEFAULT_ROLLOFF);
let dbapHull = 1;
let vbapCenterBlend = 1;
let distAtten = 0;          // dB at the centre, for sources without their own value
let stereoWidthMax = DEFAULT_STEREO_WIDTH;   // deg at full distance, for sources without their own value
let spreadFocus = DEFAULT_SPREAD_FOCUS;   // spread curve for all sources (see spreadExponent)

const flags = {
    edit_speakers: 0,
    draw_distance: 0,
    draw_spread: 1,
    draw_sources: 1,
    draw_speakers: 1,
    draw_intensity: 1,
    bypass_ui: 0,
};
let geomMode = "polar";     // "polar" | "cartesian"
let geomFormat = "pair";    // "pair" | "list"
let warned = new Set();     // keys of layout warnings already posted
let outputSourcePosition = 0;

// ================================================================ helpers

function clamp(v, lo, hi) { return v < lo ? lo : v > hi ? hi : v; }
// x/y kept inside the circular field: points beyond it move onto the perimeter
// along their ray from the centre (azimuth kept)
function clampToField(x, y) {
    x = +x || 0;
    y = +y || 0;
    const r = radiusOf(x, y);
    if (r <= FIELD_R) return [x, y];
    const k = FIELD_R / r;
    return [CX + (x - CX) * k, CY + (y - CY) * k];
}
function wrap360(a) { a %= 360; return a < 0 ? a + 360 : a; }
function azOf(x, y) { return Math.atan2(x - CX, CY - y) / RAD; }
function radiusOf(x, y) { return Math.sqrt((x - CX) ** 2 + (y - CY) ** 2); }
function rolloffToA(R) { return R / (20 * Math.log10(2)); }

// polar around the centre (distance in x/y units) -> x/y, kept inside the field
function polarToXY(az, dist) {
    const r = clamp(+dist || 0, 0, FIELD_R);
    return [CX + r * Math.sin((+az || 0) * RAD), CY - r * Math.cos((+az || 0) * RAD)];
}

// public distances are normalized: 0 = centre, 1 = perimeter
function toNorm(r) { return r / FIELD_R; }
function fromNorm(d) { return (+d || 0) * FIELD_R; }
// default ring straddles the front: 2 = L/R, 4 = quad, 8 = octagon
function ringDegrees(n) {
    const out = [];
    for (let i = 0; i < n; i++) out.push(-180 / n + (360 * i) / n);
    return out;
}

// 1-based external index -> 0-based, or -1 (with a post) if out of range
function index(i, arr, what) {
    const k = Math.floor(i) - 1;
    if (k < 0 || k >= arr.length) {
        post("syncSuite.nodes: no " + what + " " + i + "\n");
        return -1;
    }
    return k;
}

function newSpeaker(x, y, weight) {
    return { x, y, weight, az: 0 };
}

function newSource(x, y) {
    return { x, y, algorithm: VBAP, spread: 0, blur: 0, stereo: 0, stereoWidth: null,
             mirror: -1, mirrorMode: 0, distAtten: null, ch: [], dirty: true };
}

function newChannel(x, y) {
    return { x, y, px: x, py: y, hullDist: 0 };
}

// channel positions: mono = the source, stereo = L/R at az -/+ width/2, same distance
function updateChannels(o) {
    if (!o.stereo) {
        o.ch = [newChannel(o.x, o.y)];
        return;
    }
    const az = azOf(o.x, o.y);
    const r = radiusOf(o.x, o.y);
    const w = stereoWidthAt(o, r);
    o.ch = [newChannel(...polarToXY(az - w / 2, r)),
            newChannel(...polarToXY(az + w / 2, r))];
}

// maximum stereo width of a source (deg, reached at full distance)
function maxStereoWidth(o) { return o.stereoWidth === null ? stereoWidthMax : o.stereoWidth; }

// stereo width at radius r (x/y units): maximum x distance (0 centre .. 1 perimeter)
function stereoWidthAt(o, r) { return maxStereoWidth(o) * clamp(r / FIELD_R, 0, 1); }

// position of b mirroring a
function mirrorXY(x, y, mode) {
    if (mode === 0) return [1 - x, y];      // lr: az -> -az
    if (mode === 1) return [x, 1 - y];      // fb: az -> 180 - az
    return [1 - x, 1 - y];                  // point: az -> az + 180
}

// ================================================================ engine: layout

function rebuildLayout() {
    const n = spk.length;

    // VBAP: group speakers sharing an azimuth, pair adjacent groups
    spk.forEach(o => { o.az = wrap360(azOf(o.x, o.y)); });
    const order = spk.map((o, i) => i).sort((a, b) => spk[a].az - spk[b].az);
    groups = [];
    for (const i of order) {
        const last = groups[groups.length - 1];
        if (last && spk[i].az - last.az < AZ_EPS) last.members.push(i);
        else groups.push({ az: spk[i].az, members: [i] });
    }
    if (groups.length > 1 && groups[0].az + 360 - groups[groups.length - 1].az < AZ_EPS) {
        groups[0].members.push(...groups.pop().members); // e.g. 359.9999999 and 0
    }
    arcs = [];
    const m = groups.length;
    if (m > 1) {
        for (let j = 0; j < m; j++) {
            const a = groups[j];
            const b = groups[(j + 1) % m];
            arcs.push({ a, b, start: a.az, span: wrap360(b.az - a.az) });
        }
    }
    rRef = n ? spk.reduce((sum, o) => sum + radiusOf(o.x, o.y), 0) / n : SPK_RING;
    if (rRef < EPS) rRef = SPK_RING;

    // DBAP: blur scale and convex hull
    if (n > 1) {
        const mx = spk.reduce((s, o) => s + o.x, 0) / n;
        const my = spk.reduce((s, o) => s + o.y, 0) / n;
        const d2 = spk.reduce((s, o) => s + (o.x - mx) ** 2 + (o.y - my) ** 2, 0);
        sigma = Math.sqrt(d2 / (n - 1));
    } else {
        sigma = 0;
    }
    hull = convexHull();

    dia = new Float64Array(n);
    gains = src.map(() => []);
    invalidateAll();
    checkLayout();
}

function cross(o, a, b) { return (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x); }

// Andrew's monotone chain; CCW in (x, y) number space, collinear points dropped.
// 1 speaker -> [i], collinear speakers -> the 2 end points.
function convexHull() {
    const n = spk.length;
    if (n < 2) return n ? [0] : [];
    const idx = spk.map((o, i) => i).sort((a, b) => spk[a].x - spk[b].x || spk[a].y - spk[b].y);
    const lower = [];
    for (const i of idx) {
        while (lower.length >= 2 && cross(spk[lower[lower.length - 2]], spk[lower[lower.length - 1]], spk[i]) <= 0) lower.pop();
        lower.push(i);
    }
    const upper = [];
    for (let j = idx.length - 1; j >= 0; j--) {
        const i = idx[j];
        while (upper.length >= 2 && cross(spk[upper[upper.length - 2]], spk[upper[upper.length - 1]], spk[i]) <= 0) upper.pop();
        upper.push(i);
    }
    return lower.slice(0, -1).concat(upper.slice(0, -1));
}

// null if (x, y) is inside or on the hull, else [px, py, distance]
function projectOntoHull(x, y) {
    const m = hull.length;
    if (m === 0) return null;
    const p = { x, y };
    if (m >= 3) {
        let inside = true;
        for (let j = 0; j < m; j++) {
            if (cross(spk[hull[j]], spk[hull[(j + 1) % m]], p) < -1e-12) { inside = false; break; }
        }
        if (inside) return null;
    }
    let best = null;
    let bestD2 = Infinity;
    const edges = m <= 2 ? 1 : m; // a point or a segment has one edge
    for (let j = 0; j < edges; j++) {
        const a = spk[hull[j]];
        const b = spk[hull[(j + 1) % m]];
        const ex = b.x - a.x;
        const ey = b.y - a.y;
        const len2 = ex * ex + ey * ey;
        const t = len2 > 0 ? clamp(((x - a.x) * ex + (y - a.y) * ey) / len2, 0, 1) : 0;
        const qx = a.x + t * ex;
        const qy = a.y + t * ey;
        const d2 = (x - qx) ** 2 + (y - qy) ** 2;
        if (d2 < bestD2) { bestD2 = d2; best = [qx, qy]; }
    }
    if (bestD2 < 1e-24) return null;
    return [best[0], best[1], Math.sqrt(bestD2)];
}

// ================================================================ engine: layout warnings

function fmtAz(a) { a = wrap360(a); return (a > 180 ? a - 360 : a).toFixed(1) + "\u00b0"; }
function fmtList(members) {
    const ids = members.map(i => i + 1).sort((a, b) => a - b);
    return (ids.length > 1 ? "speakers " : "speaker ") + ids.join(", ");
}

// Posts each VBAP layout problem once, when it first appears (only while some
// source uses VBAP). Keys identify the problem, not its numbers, so dragging a
// speaker does not repeat the same warning.
function checkLayout() {
    const found = new Map();
    const n = spk.length;
    if (src.some(o => o.algorithm === VBAP)) {
        if (n === 0) {
            found.set("none", "no speakers are defined, so gain lists are empty. Define them with \"speaker_coords <deg> ...\".");
        } else if (n === 1) {
            found.set("one", "only one speaker is defined, so every VBAP source is sent to speaker 1 at full gain. Add speakers to be able to pan.");
        }
        spk.forEach((o, i) => {
            if (radiusOf(o.x, o.y) < CENTRE_EPS) {
                found.set("centre:" + i, "speaker " + (i + 1) + " sits on the centre, where its direction is undefined. "
                    + "It is treated as azimuth 0\u00b0 (front). Move it away from the centre to give it a real direction.");
            }
        });
        for (const grp of groups) {
            if (grp.members.length < 2) continue;
            const m = grp.members.length;
            found.set("same:" + grp.members.slice().sort((a, b) => a - b).join(","),
                fmtList(grp.members) + " share the same azimuth (" + fmtAz(grp.az) + "), so VBAP cannot tell them apart. "
                + "They are panned as one speaker and share its gain equally (gain / \u221a" + m + " each). "
                + "Give them different azimuths if they should act as separate speakers.");
        }
        for (const arc of arcs) {
            if (arc.span < WIDE_SPAN) continue;
            const key = "gap:" + Math.min(...arc.a.members) + "-" + Math.min(...arc.b.members);
            found.set(key, "the gap going clockwise from " + fmtList(arc.a.members) + " (" + fmtAz(arc.a.az) + ") to "
                + fmtList(arc.b.members) + " (" + fmtAz(arc.b.az) + ") is " + arc.span.toFixed(1)
                + "\u00b0 wide, more than a VBAP pair can handle (max " + WIDE_SPAN + "\u00b0). "
                + "Sources in that gap are crossfaded between these speakers at constant power (sin/cos) instead. "
                + "Add a speaker in the gap for real panning there.");
        }
        if (n > 1) {
            spk.forEach((o, i) => {
                const r = radiusOf(o.x, o.y);
                if (r < CENTRE_EPS || Math.abs(r - rRef) / rRef <= DIST_TOLERANCE) return;
                found.set("dist:" + i, "speaker " + (i + 1) + " is at distance " + toNorm(r).toFixed(2) + " from the centre, while the average is "
                    + toNorm(rRef).toFixed(2) + ". VBAP assumes all speakers are equally far from the listener: only its direction ("
                    + fmtAz(o.az) + ") is used and the distance is ignored (no level or delay compensation). "
                    + "Place speakers at equal distance for accurate VBAP.");
            });
        }
    }
    for (const [key, text] of found) {
        if (!warned.has(key)) post("syncSuite.nodes: VBAP warning: " + text + "\n");
    }
    warned = new Set(found.keys());
}

// ================================================================ engine: gains

// gains are computed lazily: setters only mark sources dirty
function ensureGains(k) {
    if (src[k].dirty) computeGains(k);
}

function ensureAllGains() {
    for (let k = 0; k < src.length; k++) if (src[k].dirty) computeGains(k);
}

function computeGains(k) {
    const o = src[k];
    o.dirty = false;
    updateChannels(o);
    const n = spk.length;
    if (gains[k].length !== o.ch.length || (gains[k][0] && gains[k][0].length !== n)) {
        gains[k] = o.ch.map(() => new Float64Array(n));
    }
    for (let j = 0; j < o.ch.length; j++) {
        const g = gains[k][j];
        g.fill(0);
        if (!n) continue;
        if (o.algorithm === DBAP) computeDBAP(o.ch[j], o.blur, g);
        else computeVBAP(o.ch[j], o.spread, spreadFocus, g);
    }
    const a = attenuation(o);
    if (a !== 1) for (const g of gains[k]) for (let s = 0; s < n; s++) g[s] *= a;
}

// distance attenuation as an amplitude factor: 0 dB on/outside the speaker
// ring, linear in dB down to the source's (or global) value at the centre
function attenuation(o) {
    const dB = o.distAtten === null ? distAtten : o.distAtten;
    const r = radiusOf(o.x, o.y);
    if (dB === 0 || r >= rRef) return 1;
    return Math.pow(10, (dB * (1 - r / rRef)) / 20);
}

function addGroup(group, gain, out) {
    const share = gain / Math.sqrt(group.members.length);
    for (const i of group.members) out[i] += share;
}

// adds the unit-power gains of one virtual source at azimuth phi into out,
// scaled by weight
function vbapPoint(phi, out, weight = 1) {
    if (groups.length === 1) { addGroup(groups[0], weight, out); return; }
    // arcs are sorted by start and cover the circle: last arc starting <= phi
    const p = wrap360(phi);
    let lo = 0;
    let hi = arcs.length - 1;
    if (p < arcs[0].start) {
        lo = arcs.length - 1;
    } else {
        while (lo < hi) {
            const mid = (lo + hi + 1) >> 1;
            if (arcs[mid].start <= p) lo = mid; else hi = mid - 1;
        }
    }
    const arc = arcs[lo];
    const d = Math.min(wrap360(p - arc.start), arc.span);
    let ga, gb;
    if (arc.span < WIDE_SPAN) {
        // sine law == p^T L^-1 for unit vectors at 0 and span
        const s = Math.sin(arc.span * RAD);
        ga = Math.sin((arc.span - d) * RAD) / s;
        gb = Math.sin(d * RAD) / s;
    } else {
        const t = (d / arc.span) * Math.PI / 2;
        ga = Math.cos(t);
        gb = Math.sin(t);
    }
    const norm = Math.sqrt(ga * ga + gb * gb) || 1;
    addGroup(arc.a, (ga / norm) * weight, out);
    addGroup(arc.b, (gb / norm) * weight, out);
}

// Spread: virtual sources all around the circle (1 deg apart), weighted by a
// smooth bell centred on the source, w = ((1 + cos a) / 2)^p. p is set so the
// weight halves at 180 deg x spread^focus (spread_focus, default 1.6: spread
// 0.25 -> 20 deg, 0.5 -> 59 deg, 0.75 -> 114 deg; 1 -> p = 0, a flat weight,
// all directions equal). 1.6 puts the speakers 45 deg away 3 dB below the one
// the source points at, at spread 0.5 (octagon). Higher focus keeps sources
// pointed until spread is high, lower focus goes flat sooner.

// the spread's weight in a direction a (deg from the source's direction), 0..1,
// as the listener gets it (bell, plus the equal blend near spread 1): for drawing
function spreadWeight(spread, a, focus = DEFAULT_SPREAD_FOCUS) {
    if (spread < EPS) return Math.abs(a) < 1 ? 1 : 0;
    const p = spreadExponent(spread, focus);
    const w = p === 0 ? 1 : Math.pow((1 + Math.cos(a * RAD)) / 2, p);
    const e = Math.pow(spread, 8);
    return (1 - e) * w + e;
}

function spreadExponent(spread, focus = DEFAULT_SPREAD_FOCUS) {
    const half = 180 * Math.pow(spread, focus);
    if (half >= 180 - 1e-9) return 0;
    return Math.log(0.5) / Math.log((1 + Math.cos(half * RAD)) / 2);
}

// c: one channel {x, y}; spread 0..1
function computeVBAP(c, spread, focus, g) {
    const az = azOf(c.x, c.y);
    if (spread < EPS) {
        vbapPoint(az, g);
    } else {
        const p = spreadExponent(spread, focus);
        for (let k = -179; k <= 180; k += VS_STEP) {
            const w = p === 0 ? 1 : Math.pow((1 + Math.cos(k * RAD)) / 2, p);
            if (w > 1e-6) vbapPoint(az + k, g, w);
        }
    }
    let pw = 0;
    for (let s = 0; s < g.length; s++) pw += g[s] * g[s];
    pw = Math.sqrt(pw);
    if (pw > 0) for (let s = 0; s < g.length; s++) g[s] /= pw;

    // spread 1 = every speaker equal on any layout: near the top the result
    // blends (constant power) into equal gains. weight spread^8: 0.4% at 0.5,
    // 43% at 0.9, 100% at 1
    if (spread > 0) {
        const e = Math.pow(spread, 8);
        for (let s = 0; s < g.length; s++) g[s] = Math.sqrt((1 - e) * g[s] * g[s] + e / g.length);
    }

    // constant-power blend towards all-equal inside the ring
    const r = radiusOf(c.x, c.y);
    if (vbapCenterBlend && r < rRef) {
        const t = r / rRef;
        const e = (1 - t) / g.length;
        for (let s = 0; s < g.length; s++) g[s] = Math.sqrt(t * g[s] * g[s] + e);
    }
}

// c: one channel {x, y}; sets c.px, c.py, c.hullDist
function computeDBAP(c, blur, g) {
    let x = c.x;
    let y = c.y;
    if (dbapHull) {
        const pr = projectOntoHull(x, y);
        if (pr) { x = pr[0]; y = pr[1]; c.hullDist = pr[2]; }
    }
    c.px = x;
    c.py = y;
    const r2 = (blur * sigma) ** 2;
    const n = spk.length;

    // exact limit (paper eq. 7) when the source sits on speaker(s) with no blur
    let w2zero = 0;
    for (let s = 0; s < n; s++) {
        const d2 = (x - spk[s].x) ** 2 + (y - spk[s].y) ** 2 + r2;
        dia[s] = d2;
        if (d2 < 1e-20 && spk[s].weight > 0) w2zero += spk[s].weight ** 2;
    }
    if (w2zero > 0) {
        const kk = 1 / Math.sqrt(w2zero);
        for (let s = 0; s < n; s++) if (dia[s] < 1e-20 && spk[s].weight > 0) g[s] = spk[s].weight * kk;
        return;
    }

    let k2inv = 0;
    for (let s = 0; s < n; s++) {
        const w = spk[s].weight;
        dia[s] = Math.pow(dia[s], 0.5 * dbapA);
        if (w > 0) k2inv += (w * w) / (dia[s] * dia[s]);
    }
    if (!(k2inv > 0)) return; // every weight is 0
    const kk = 1 / Math.sqrt(k2inv);
    for (let s = 0; s < n; s++) {
        const w = spk[s].weight;
        g[s] = w > 0 ? (w * kk) / dia[s] : 0;
    }
}

// settings that affect every source: recomputed lazily on the next get_gains / repaint
function invalidateAll() {
    for (const o of src) o.dirty = true;
}

// ================================================================ output

function emitGains(k) {
    ensureGains(k);
    const o = src[k];
    for (let j = 0; j < o.ch.length; j++) {
        if (dbapHull && o.algorithm === DBAP) outlet(1, ["hull_distance", k + 1, j + 1, o.ch[j].hullDist]);
        outlet(0, [k + 1, j + 1, ...gains[k][j]]);
    }
}

// "[i]" helper: with an index -> that source, without -> all sources
function perSource(args, fn) {
    if (args.length) {
        const k = index(args[0], src, "source");
        if (k >= 0) fn(k);
    } else {
        for (let k = 0; k < src.length; k++) fn(k);
    }
}

// knob as seen from the speaker
function pair(k, s) {
    const dx = src[k].x - spk[s].x;
    const dy = src[k].y - spk[s].y;
    if (geomMode === "cartesian") return [toNorm(dx), toNorm(dy)];
    return [Math.atan2(dx, -dy) / RAD, toNorm(Math.sqrt(dx * dx + dy * dy))];
}

function emitGeometry(k) {
    if (geomFormat === "list") {
        const row = [k + 1];
        for (let s = 0; s < spk.length; s++) row.push(...pair(k, s));
        outlet(1, row);
    } else {
        for (let s = 0; s < spk.length; s++) outlet(1, [k + 1, s + 1, ...pair(k, s)]);
    }
}

// pattr clients are only notified for mouse edits, so automation stays cheap
function changed(fromMouse) {
    if (fromMouse && typeof notifyclients === "function") notifyclients();
    if (!flags.bypass_ui) mgraphics.redraw();
}

function speakerPolar(s) {
    const o = spk[s];
    return [azOf(o.x, o.y), toNorm(radiusOf(o.x, o.y))];
}

function sourcePolar(k) {
    const o = src[k];
    return [azOf(o.x, o.y), toNorm(radiusOf(o.x, o.y))];
}

// ================================================================ state setters

// sets the position only; false if unchanged
function place(k, x, y) {
    const o = src[k];
    if (Math.abs(o.x - x) < EPS && Math.abs(o.y - y) < EPS) return false;
    o.x = x;
    o.y = y;
    o.dirty = true;
    return true;
}

// moves a source and its mirror partner
function setSource(k, x, y, fromMouse) {
    [x, y] = clampToField(x, y);
    if (!place(k, x, y)) return;
    const o = src[k];
    const m = o.mirror;
    if (m >= 0) place(m, ...mirrorXY(x, y, o.mirrorMode));
    if (fromMouse && outputSourcePosition) {
        outlet(2, ["source", k + 1, ...sourcePolar(k)]);
        if (m >= 0) outlet(2, ["source", m + 1, ...sourcePolar(m)]);
    }
    changed(fromMouse);
}

// state messages for parameters the mouse can change
const PARAM_MESSAGE = { spread: "source_spread", blur: "source_blur", stereoWidth: "source_stereo_width" };

// field = "spread" | "blur" | "algorithm" | "stereo" | "stereoWidth"
function setSourceParam(k, field, v, fromMouse) {
    const o = src[k];
    if (field === "spread") v = clamp(+v || 0, 0, 1);
    else if (field === "blur") v = clamp(+v || 0, 0, MAX_BLUR);
    else if (field === "stereoWidth") v = clamp(+v || 0, 0, 180);
    else if (field === "stereo") v = v ? 1 : 0;
    else v = Math.floor(v) === DBAP ? DBAP : VBAP;
    if (o[field] !== null && Math.abs(o[field] - v) < EPS) return;
    o[field] = v;
    o.dirty = true;
    if (field === "algorithm") checkLayout();
    if (fromMouse) outlet(2, [PARAM_MESSAGE[field], k + 1, v]);
    changed(fromMouse);
}

function unmirror(k) {
    const m = src[k].mirror;
    if (m >= 0) src[m].mirror = -1;
    src[k].mirror = -1;
}

function setSpeaker(s, x, y, fromMouse) {
    [x, y] = clampToField(x, y);
    const o = spk[s];
    if (Math.abs(o.x - x) < EPS && Math.abs(o.y - y) < EPS) return;
    o.x = x;
    o.y = y;
    rebuildLayout();
    if (fromMouse) outlet(2, ["speaker", s + 1, ...speakerPolar(s)]);
    changed(fromMouse);
}

function setWeight(s, v) {
    v = Math.max(0, +v || 0);
    if (Math.abs(spk[s].weight - v) < EPS) return;
    spk[s].weight = v;
    for (let k = 0; k < src.length; k++) {
        if (src[k].algorithm === DBAP) src[k].dirty = true;
    }
    changed();
}

// "[i] <v>" helper: with an index -> one, without -> all
function perItem(args, arr, what, fn) {
    if (args.length >= 2) {
        const i = index(args[0], arr, what);
        if (i >= 0) fn(i, args[1]);
    } else if (args.length === 1) {
        for (let i = 0; i < arr.length; i++) fn(i, args[0]);
    }
}

// ================================================================ messages

function speaker_coords(...degs) {
    const old = spk;
    spk = degs.map((a, i) => {
        const [x, y] = polarToXY(a, SPK_RING);
        return newSpeaker(x, y, old[i] ? old[i].weight : 1);
    });
    rebuildLayout();
    changed();
}

function num_sources(n) {
    n = Math.max(0, Math.floor(n) || 0);
    for (let i = src.length; i < n; i++) src.push(newSource(...polarToXY((360 * i) / n, SRC_RING)));
    src.length = n;
    for (const o of src) if (o.mirror >= n) o.mirror = -1;
    if (selected >= n) selected = n - 1;
    if (selected < 0 && n > 0) selected = 0;
    rebuildLayout();
    changed();
}

function algorithm(...a) { perItem(a, src, "source", (k, v) => setSourceParam(k, "algorithm", v, false)); }

function speaker(i, az, dist) {
    const s = index(i, spk, "speaker");
    if (s >= 0) setSpeaker(s, ...polarToXY(az, dist === undefined ? SPK_RING : fromNorm(dist)), false);
}
function speaker_azimuth(i, az) {
    const s = index(i, spk, "speaker");
    if (s >= 0) setSpeaker(s, ...polarToXY(az, radiusOf(spk[s].x, spk[s].y)), false);
}
function speaker_distance(i, dist) {
    const s = index(i, spk, "speaker");
    if (s >= 0) setSpeaker(s, ...polarToXY(azOf(spk[s].x, spk[s].y), fromNorm(dist)), false);
}
function speaker_weight(...a) { perItem(a, spk, "speaker", setWeight); }

function source(i, az, dist) {
    const k = index(i, src, "source");
    if (k >= 0) setSource(k, ...polarToXY(az, fromNorm(dist)), false);
}
function source_azimuth(i, az) {
    const k = index(i, src, "source");
    if (k >= 0) setSource(k, ...polarToXY(az, radiusOf(src[k].x, src[k].y)), false);
}
function source_distance(i, dist) {
    const k = index(i, src, "source");
    if (k >= 0) setSource(k, ...polarToXY(azOf(src[k].x, src[k].y), fromNorm(dist)), false);
}
function source_xy(i, x, y) { const k = index(i, src, "source"); if (k >= 0) setSource(k, x, y, false); }
function get_source(...a) { perSource(a, k => outlet(2, ["source", k + 1, ...sourcePolar(k)])); }
function output_source_position(v) { outputSourcePosition = v ? 1 : 0; }
function source_spread(...a) { perItem(a, src, "source", (k, v) => setSourceParam(k, "spread", v, false)); }
function source_blur(...a) { perItem(a, src, "source", (k, v) => setSourceParam(k, "blur", v, false)); }
function sources_mode(...flags) {
    if (flags.length > src.length) {
        post("syncSuite.nodes: sources_mode has " + flags.length + " flags but there are " + src.length
            + " sources; the extra flags are ignored\n");
    }
    const n = Math.min(flags.length, src.length);
    for (let k = 0; k < n; k++) setSourceParam(k, "stereo", flags[k], false);
}
function stereo_width(...a) {
    if (a.length !== 1) {
        post("syncSuite.nodes: stereo_width takes one value (the maximum for all sources); use source_stereo_width <i> <deg> for one source\n");
        return;
    }
    stereoWidthMax = clamp(+a[0] || 0, 0, 180);
    for (const o of src) {               // last one wins: the global value replaces every source's own
        if (o.stereo) o.dirty = true;
        o.stereoWidth = null;
    }
    changed();
}

function spread_focus(v) {
    spreadFocus = clamp(+v || 0, MIN_SPREAD_FOCUS, MAX_SPREAD_FOCUS);
    for (const o of src) if (o.algorithm === VBAP && o.spread > 0) o.dirty = true;
    changed();
}

function source_stereo_width(i, deg) {
    const k = index(i, src, "source");
    if (k < 0) return;
    if (deg === undefined) {
        src[k].stereoWidth = null;
        src[k].dirty = true;
        changed();
    } else {
        setSourceParam(k, "stereoWidth", deg, false);
    }
}

function mirror_sources(...a) {
    if (a.length === 0) {
        src.forEach(o => { o.mirror = -1; });
        changed();
        return;
    }
    const k = index(a[0], src, "source");
    if (k < 0) return;
    if (a.length === 1) {
        unmirror(k);
        changed();
        return;
    }
    const m = index(a[1], src, "source");
    if (m < 0) return;
    if (m === k) {
        post("syncSuite.nodes: mirror_sources needs two different sources\n");
        return;
    }
    const mode = a.length > 2 ? MIRROR_MODES.indexOf(String(a[2])) : 0;
    if (mode < 0) {
        post("syncSuite.nodes: mirror_sources mode must be lr, fb or point\n");
        return;
    }
    unmirror(k);
    unmirror(m);
    src[k].mirror = m;
    src[m].mirror = k;
    src[k].mirrorMode = mode;
    src[m].mirrorMode = mode;
    place(m, ...mirrorXY(src[k].x, src[k].y, mode));
    changed();
}

function dbap_rolloff(R) {
    R = +R;
    if (!(R > 0)) {
        post("syncSuite.nodes: dbap_rolloff must be > 0 dB\n");
        return;
    }
    dbapRolloff = R;
    dbapA = rolloffToA(R);
    invalidateAll();
    changed();
}

function dbap_hull(v) { dbapHull = v ? 1 : 0; invalidateAll(); changed(); }
function vbap_center_blend(v) { vbapCenterBlend = v ? 1 : 0; invalidateAll(); changed(); }

function clampDb(v) { return clamp(+v || 0, -120, 24); }

function distance_attenuation(dB) {
    distAtten = clampDb(dB);
    for (const o of src) {               // last one wins: the global value replaces every source's own
        o.distAtten = null;
        o.dirty = true;
    }
    changed();
}

function source_distance_attenuation(i, dB) {
    const k = index(i, src, "source");
    if (k < 0) return;
    src[k].distAtten = dB === undefined ? null : clampDb(dB);
    src[k].dirty = true;
    changed();
}

function setFlag(name, v) {
    flags[name] = v ? 1 : 0;
    if (name === "edit_speakers" && !flags.edit_speakers && drag && drag.kind === "speaker") drag = null;
    mgraphics.redraw();
}
function edit_speakers(v) { setFlag("edit_speakers", v); }
function draw_distance(v) { setFlag("draw_distance", v); }
function draw_spread(v) { setFlag("draw_spread", v); }
function draw_sources(v) { setFlag("draw_sources", v); }
function draw_speakers(v) { setFlag("draw_speakers", v); }
function draw_intensity(v) { setFlag("draw_intensity", v); }

function speaker_size(px) { spkR = clamp(+px || 0, 4, 60) / 2; mgraphics.redraw(); }
function source_size(px) { knobR = clamp(+px || 0, 4, 60) / 2; mgraphics.redraw(); }

function select_source(i) {
    const k = index(i, src, "source");
    if (k < 0) return;
    selected = k;
    mgraphics.redraw();
}
function bypass_ui(v) { drag = null; setFlag("bypass_ui", v); }

function geometry(mode) {
    if (mode !== "polar" && mode !== "cartesian") {
        post("syncSuite.nodes: geometry must be polar or cartesian\n");
        return;
    }
    geomMode = mode;
}

function format(f) {
    if (f !== "pair" && f !== "list") {
        post("syncSuite.nodes: format must be pair or list\n");
        return;
    }
    geomFormat = f;
}

function get_gains(...a) { perSource(a, emitGains); }
function get_geometry(...a) { perSource(a, emitGeometry); }

// the layout as azimuths: what this object and syncSuite.virtualspeakers~ take as input
function get_speakers() {
    outlet(2, ["speaker_coords", ...spk.map(o => azOf(o.x, o.y))]);
}

function dump() {
    outlet(2, ["distance_attenuation", distAtten]);
    outlet(2, ["stereo_width", stereoWidthMax]);
    outlet(2, ["spread_focus", spreadFocus]);
    spk.forEach((o, i) => {
        outlet(2, ["speaker", i + 1, ...speakerPolar(i)]);
        outlet(2, ["speaker_weight", i + 1, o.weight]);
    });
    if (src.length) outlet(2, ["sources_mode", ...src.map(o => o.stereo)]);
    src.forEach((o, i) => {
        outlet(2, ["source", i + 1, ...sourcePolar(i)]);
        outlet(2, ["algorithm", i + 1, o.algorithm]);
        outlet(2, ["source_spread", i + 1, o.spread]);
        outlet(2, ["source_blur", i + 1, o.blur]);
        if (o.stereoWidth !== null) outlet(2, ["source_stereo_width", i + 1, o.stereoWidth]);
        if (o.distAtten !== null) outlet(2, ["source_distance_attenuation", i + 1, o.distAtten]);
        if (o.mirror > i) outlet(2, ["mirror_sources", i + 1, o.mirror + 1, MIRROR_MODES[o.mirrorMode]]);
    });
}

// ================================================================ pattr / embedding

const STATE_VERSION = 8;
const SRC_FIELDS = 12;

// flat: <version> <nspk> <nsrc> [x y weight]*nspk
//       [x y algorithm spread blur stereo hasOwnStereoWidth stereoWidth mirror(1-based, 0 = none)
//        mirrorMode hasOwnAttenuation attenuation]*nsrc
function getvalueof() {
    const v = [STATE_VERSION, spk.length, src.length];
    spk.forEach(o => v.push(o.x, o.y, o.weight));
    src.forEach(o => v.push(o.x, o.y, o.algorithm, o.spread, o.blur, o.stereo,
                            o.stereoWidth === null ? 0 : 1, o.stereoWidth === null ? 0 : o.stereoWidth,
                            o.mirror + 1, o.mirrorMode,
                            o.distAtten === null ? 0 : 1, o.distAtten === null ? 0 : o.distAtten));
    return v;
}

function setvalueof(...v) {
    if (v[0] !== STATE_VERSION) return;
    const ns = Math.floor(v[1]) || 0;
    const nk = Math.floor(v[2]) || 0;
    if (v.length < 3 + ns * 3 + nk * SRC_FIELDS) return;
    let p = 3;
    spk = [];
    for (let i = 0; i < ns; i++, p += 3) spk.push(newSpeaker(v[p], v[p + 1], v[p + 2]));
    src = [];
    for (let i = 0; i < nk; i++, p += SRC_FIELDS) {
        const o = newSource(v[p], v[p + 1]);
        o.algorithm = v[p + 2] === DBAP ? DBAP : VBAP;
        o.spread = v[p + 3];
        o.blur = v[p + 4];
        o.stereo = v[p + 5] ? 1 : 0;
        o.stereoWidth = v[p + 6] ? clamp(+v[p + 7] || 0, 0, 180) : null;
        const m = Math.floor(v[p + 8]) - 1;
        o.mirror = m >= 0 && m < nk && m !== i ? m : -1;
        o.mirrorMode = clamp(Math.floor(v[p + 9]) || 0, 0, 2);
        o.distAtten = v[p + 10] ? clampDb(v[p + 11]) : null;
        src.push(o);
    }
    rebuildLayout();
    changed();
}

function save() {
    if (typeof embedmessage !== "function") return;
    embedmessage("dbap_rolloff", dbapRolloff);
    embedmessage("dbap_hull", dbapHull);
    embedmessage("vbap_center_blend", vbapCenterBlend);
    embedmessage("distance_attenuation", distAtten);
    embedmessage("stereo_width", stereoWidthMax);
    embedmessage("spread_focus", spreadFocus);
    embedmessage("output_source_position", outputSourcePosition);
    embedmessage("setvalueof", ...getvalueof());
    for (const name in flags) embedmessage(name, flags[name]);
    embedmessage("speaker_size", spkR * 2);
    embedmessage("source_size", knobR * 2);
    embedmessage("format", geomFormat);
    embedmessage("geometry", geomMode);
}

// ================================================================ mouse

const TEXT_INSET = 4;       // overlay text distance from the object's edges, px
const TEXT_TOP = 11;        // baseline of the top-left label, px
const PAD = 18;             // speakers sit on the perimeter: leave room for them and their glow
let knobR = 8;              // source knob radius, px (source_size = diameter)
const ARCH_STEP = 4;        // deg per segment of the spread arch
const HALO_MAX = 0.06;      // VBAP halo growth at spread 1, in field units (kept small: the arch shows the spread)
let spkR = 7;               // speaker half-width, px (speaker_size = width)
const DB_FLOOR = -24;       // speaker colour: 0 dB = full, DB_FLOOR and below = off

let drag = null;            // {kind: source|width|stereo|speaker, i, ...}
let selected = 0;           // source whose levels the speakers show (-1 = none)
let view = { x0: 0, y0: 0, side: 1 };

function toScreen(x, y) { return [view.x0 + x * view.side, view.y0 + y * view.side]; }
function toWorld(px, py) { return [(px - view.x0) / view.side, (py - view.y0) / view.side]; }

// top-most speaker under the mouse, or -1
// on click (output_source_position 1): position, spread (blur for DBAP), the
// maximum stereo width (stereo sources) and the distance attenuation
// currently applied, in dB
function reportSource(k) {
    const o = src[k];
    outlet(2, ["source", k + 1, ...sourcePolar(k)]);
    outlet(2, ["source_spread", k + 1, o.spread]);
    if (o.algorithm === DBAP) outlet(2, ["source_blur", k + 1, o.blur]);
    if (o.stereo) outlet(2, ["source_stereo_width", k + 1, maxStereoWidth(o)]);
    const a = attenuation(o);
    outlet(2, ["source_attenuation", k + 1, a === 1 ? 0 : 20 * Math.log10(a)]);
}

function hitSpeaker(px, py) {
    const r = spkR + 3;
    for (let s = spk.length - 1; s >= 0; s--) {
        const [x, y] = toScreen(spk[s].x, spk[s].y);
        if ((px - x) ** 2 + (py - y) ** 2 <= r * r) return s;
    }
    return -1;
}

// top-most source channel under the mouse: [source, channel] or [-1, -1]
function hitChannel(px, py) {
    ensureAllGains(); // channel positions
    const r = knobR + 2;
    for (let k = src.length - 1; k >= 0; k--) {
        const ch = src[k].ch;
        for (let j = ch.length - 1; j >= 0; j--) {
            const [x, y] = toScreen(ch[j].x, ch[j].y);
            if ((px - x) ** 2 + (py - y) ** 2 <= r * r) return [k, j];
        }
    }
    return [-1, -1];
}

function onclick(x, y, but, cmd, shift, capslock, option, ctrl) {
    drag = null;
    if (flags.bypass_ui) return;
    const [wx, wy] = toWorld(x, y);
    if (flags.edit_speakers && flags.draw_speakers) {
        const s = hitSpeaker(x, y);
        if (s >= 0) {
            drag = { kind: "speaker", i: s, ox: spk[s].x - wx, oy: spk[s].y - wy };
            if (outputSourcePosition) outlet(2, ["speaker", s + 1, ...speakerPolar(s)]);
        }
    }
    if (!drag && flags.draw_sources) {
        const [k, j] = hitChannel(x, y);
        if (k >= 0) {
            selected = k;
            if (outputSourcePosition) reportSource(k);   // clicked, even without moving
            const o = src[k];
            const c = o.ch[j];
            if (cmd) drag = { kind: "width", i: k, py: y, v0: o.algorithm === DBAP ? o.blur : o.spread };
            else if (shift && o.stereo) drag = { kind: "stereo", i: k, py: y, v0: maxStereoWidth(o) };
            else drag = { kind: "source", i: k, j, stereo: o.stereo, ox: c.x - wx, oy: c.y - wy };
        }
    }
    mgraphics.redraw();
}

function ondrag(x, y, but) {
    if (!drag) return;
    if (!but) {
        drag = null;
        mgraphics.redraw();
        return;
    }
    const [wx, wy] = toWorld(x, y);
    const i = drag.i;
    switch (drag.kind) {
        case "source": {
            // the grabbed knob follows the mouse; for L/R, solve the centre from it
            const tx = wx + drag.ox;
            const ty = wy + drag.oy;
            if (!drag.stereo) {
                setSource(i, tx, ty, true);
            } else {
                const half = stereoWidthAt(src[i], Math.min(radiusOf(tx, ty), FIELD_R)) / 2;
                const az = azOf(tx, ty) + (drag.j === 0 ? half : -half);
                setSource(i, ...polarToXY(az, radiusOf(tx, ty)), true);
            }
            break;
        }
        case "stereo": setSourceParam(i, "stereoWidth", drag.v0 + (drag.py - y), true); break;
        case "width":
            if (src[i].algorithm === DBAP) setSourceParam(i, "blur", drag.v0 + (drag.py - y) * 0.01, true);
            else setSourceParam(i, "spread", drag.v0 + (drag.py - y) * 0.005, true);
            break;
        case "speaker": setSpeaker(i, wx + drag.ox, wy + drag.oy, true); break;
    }
}

function onresize() { mgraphics.redraw(); }

// ================================================================ drawing

// Live's own UI font (shipped with Live and Max): Ableton Sans Small
const FONT = "Ableton Sans Small Regular";
const FONT_BOLD = "Ableton Sans Small Bold";
const FONT_SIZE = 9;

const C = {
    bg: [0.114, 0.114, 0.114],
    field: [0.157, 0.157, 0.157],
    line: [1, 1, 1],
    text: [0.72, 0.72, 0.72],
    dim: [0.45, 0.45, 0.45],
    speakerOff: [0.27, 0.27, 0.27],  // silent speakers stay dark so lit ones stand out
    hot: [1.0, 0.92, 0.6],           // rim of speakers near 0 dB
    ink: [0.07, 0.07, 0.07],
    accent: [1.0, 0.65, 0.16],   // Live orange
    edit: [0.36, 0.78, 1.0],     // Live blue
};

// Live clip colours
const PALETTE = [
    [1.0, 0.58, 0.65], [1.0, 0.65, 0.16], [0.97, 0.96, 0.49], [0.75, 0.98, 0.0],
    [0.15, 1.0, 0.66], [0.36, 1.0, 0.91], [0.55, 0.77, 1.0], [0.57, 0.65, 1.0],
    [0.85, 0.42, 0.89], [0.9, 0.33, 0.63], [0.8, 0.6, 0.15], [0.1, 1.0, 0.18],
];

function rgba(c, a) { mgraphics.set_source_rgba(c[0], c[1], c[2], a === undefined ? 1 : a); }
function circle(x, y, r) { mgraphics.ellipse(x - r, y - r, 2 * r, 2 * r); }
function roundRect(x, y, w, h, r) { mgraphics.rectangle_rounded(x, y, w, h, r, r); }

// power received by a speaker -> 0..1 on a dB scale (0 dB = 1, DB_FLOOR = 0)
function levelOf(p) {
    return p > 0 ? clamp(1 - (10 * Math.log10(p)) / DB_FLOOR, 0, 1) : 0;
}

function mix(a, b, t) { return [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t]; }

function fmtFocus(v) { return (Math.round(v * 100) / 100).toString(); }

function fmtDb(v) { return v > 1e-6 ? (20 * Math.log10(v)).toFixed(1) : "-inf"; }

function label(str, x, y) {
    const [tw, th] = mgraphics.text_measure(str);
    mgraphics.move_to(x - tw / 2, y + th / 2 - 2);
    mgraphics.show_text(str);
}

function text(str, x, y) {
    mgraphics.move_to(x, y);
    mgraphics.show_text(str);
}

// bottom right while a source is dragged: its distance attenuation right now
function readoutRight() {
    if (!drag || drag.kind === "speaker") return "";
    const a = attenuation(src[drag.i]);
    return "distance attenuation " + (a === 1 ? "0.0" : fmtDb(a)) + " dB";
}

function readout() {
    if (!drag) return "";
    const i = drag.i;
    switch (drag.kind) {
        case "source": {
            const o = src[i];
            return "source " + (i + 1) + (o.stereo ? " stereo" : "")
                + "   az " + azOf(o.x, o.y).toFixed(1) + "\u00b0   distance " + toNorm(radiusOf(o.x, o.y)).toFixed(2)
                + (o.algorithm === DBAP ? "   blur " + o.blur.toFixed(2) : "   spread " + o.spread.toFixed(2))
                + (o.mirror >= 0 ? "   mirror " + (o.mirror + 1) + " (" + MIRROR_MODES[o.mirrorMode] + ")" : "");
        }
        case "stereo": {
            const o = src[i];
            return "source " + (i + 1) + "   stereo width " + maxStereoWidth(o).toFixed(0) + "\u00b0 at full distance, "
                + stereoWidthAt(o, radiusOf(o.x, o.y)).toFixed(0) + "\u00b0 here";
        }
        case "width": {
            const o = src[i];
            return o.algorithm === DBAP
                ? "source " + (i + 1) + "   blur " + o.blur.toFixed(2)
                : "source " + (i + 1) + "   spread " + o.spread.toFixed(2) + " (" + (o.spread * 360).toFixed(0) + "\u00b0)";
        }
        case "speaker": {
            const o = spk[i];
            return "speaker " + (i + 1) + "   az " + azOf(o.x, o.y).toFixed(1) + "\u00b0   distance " + toNorm(radiusOf(o.x, o.y)).toFixed(2);
        }
    }
    return "";
}

// halo radius in pixels, 0 = none. VBAP: grows with spread (1 = HALO_MAX
// of the field). DBAP: the blur radius r_s = blur * sigma, at least visible.
function haloRadius(o, side) {
    if (o.algorithm === DBAP) {
        return o.blur > 0 ? Math.max(knobR + 3, o.blur * sigma * side) : 0;
    }
    return o.spread > 0 ? knobR + 6 + o.spread * HALO_MAX * side : 0;
}

function paint() {
    const g = mgraphics;
    const [w, h] = mgraphics.size;

    rgba(C.bg);
    g.rectangle(0, 0, w, h);
    g.fill();

    g.select_font_face(FONT);
    g.set_font_size(FONT_SIZE);

    if (flags.bypass_ui) {
        rgba(C.dim);
        label("UI bypassed", w / 2, h / 2);
        return;
    }

    ensureAllGains(); // speaker glow, lines, spread/projection need fresh gains

    const side = Math.max(1, Math.min(w, h) - 2 * PAD);
    view = { x0: (w - side) / 2, y0: (h - side) / 2, side };
    const [cx, cy] = toScreen(CX, CY);
    const anyDBAP = src.some(o => o.algorithm === DBAP);
    const anyVBAP = src.some(o => o.algorithm === VBAP);

    // circular field: rings at distance 0.25 / 0.5 / 0.75, cross through the centre
    const fr = FIELD_R * side;
    rgba(C.field);
    circle(cx, cy, fr);
    g.fill();
    g.set_line_width(1);
    rgba(C.line, 0.045);
    for (let i = 1; i < 4; i++) {
        circle(cx, cy, (fr * i) / 4);
        g.stroke();
    }
    g.move_to(cx - fr, cy); g.line_to(cx + fr, cy);
    g.move_to(cx, cy - fr); g.line_to(cx, cy + fr);
    g.stroke();
    rgba(C.line, 0.12);
    circle(cx, cy, fr);
    g.stroke();

    // VBAP reference ring (when the speakers are not on the perimeter) + listener
    if (anyVBAP) {
        if (Math.abs(rRef - FIELD_R) > 1e-3) {
            rgba(C.line, 0.08);
            circle(cx, cy, rRef * side);
            g.stroke();
        }
        rgba(C.dim);
        g.move_to(cx, cy - 5); g.line_to(cx + 4, cy + 3); g.line_to(cx - 4, cy + 3);
        g.close_path();
        g.fill();
    }

    // DBAP convex hull
    if (anyDBAP && dbapHull && hull.length > 1) {
        rgba(C.line, 0.14);
        hull.forEach((s, j) => {
            const [x, y] = toScreen(spk[s].x, spk[s].y);
            if (j === 0) g.move_to(x, y); else g.line_to(x, y);
        });
        g.close_path();
        g.stroke();
    }

    // spread (VBAP) / blur (DBAP): a halo around each source knob
    if (flags.draw_sources && flags.draw_spread) {
        src.forEach((o, k) => {
            const r = haloRadius(o, side);
            if (r <= 0) return;
            const c = PALETTE[k % PALETTE.length];
            for (const ch of o.ch) {
                const [x, y] = toScreen(ch.x, ch.y);
                if (o.algorithm === DBAP) {
                    rgba(c, 0.13);
                    circle(x, y, r);
                    g.fill_preserve();
                    rgba(c, 0.45);
                    g.stroke();
                    continue;
                }
                // VBAP: faint halo + an arch whose thickness and brightness follow the
                // spread weight in each direction (as seen from the listener)
                rgba(c, 0.06);
                circle(x, y, r);
                g.fill();
                const az = azOf(ch.x, ch.y);
                for (const pass of [0, 1]) {            // dark edge underneath, then the colour
                    for (let a = -180; a < 180; a += ARCH_STEP) {
                        const w = spreadWeight(o.spread, a + ARCH_STEP / 2, spreadFocus);
                        if (w < 0.02) continue;
                        const lw = 1.5 + 7 * w;
                        if (pass === 0) {
                            rgba(C.bg, 0.5 * w);
                            g.set_line_width(lw + 2);
                        } else {
                            rgba(c, 0.3 + 0.7 * w);
                            g.set_line_width(lw);
                        }
                        g.arc(x, y, r, (az + a - 90) * RAD, (az + a + ARCH_STEP - 90) * RAD);
                        g.stroke();
                    }
                }
                g.set_line_width(1);
            }
        });
    }

    // source -> speaker lines, opacity follows gain
    if (flags.draw_distance && flags.draw_sources) {
        src.forEach((o, k) => {
            const c = PALETTE[k % PALETTE.length];
            o.ch.forEach((ch, j) => {
                const [kx, ky] = toScreen(ch.x, ch.y);
                spk.forEach((p, s) => {
                    const [x, y] = toScreen(p.x, p.y);
                    rgba(c, 0.06 + 0.6 * gains[k][j][s]);
                    g.move_to(kx, ky);
                    g.line_to(x, y);
                    g.stroke();
                });
            });
        });
    }

    // speakers, lit by the power they receive from the selected source (L + R for stereo)
    const sel = selected >= 0 && selected < src.length ? gains[selected] : [];
    if (flags.draw_speakers) {
        spk.forEach((o, s) => {
            const [x, y] = toScreen(o.x, o.y);
            let p = 0;
            for (const gc of sel) p += gc[s] * gc[s];
            const t = levelOf(p);
            const r = spkR * (1 + 0.35 * t);          // the speaker swells with level
            if (t > 0) {
                // two-layer glow, up to 16 px beyond the speaker at 0 dB
                for (const [grow, alpha] of [[16 * t, 0.18], [7 * t, 0.4]]) {
                    rgba(C.accent, alpha * t);
                    roundRect(x - r - grow, y - r - grow, 2 * (r + grow), 2 * (r + grow), 3 + grow);
                    g.fill();
                }
            }
            rgba(mix(C.speakerOff, C.accent, t));
            roundRect(x - r, y - r, 2 * r, 2 * r, 3);
            g.fill();
            if (t > 0.5) {
                rgba(C.hot, (t - 0.5) * 2);
                g.set_line_width(1.5);
                roundRect(x - r, y - r, 2 * r, 2 * r, 3);
                g.stroke();
                g.set_line_width(1);
            }
            if (flags.edit_speakers) {
                const active = drag && drag.kind === "speaker" && drag.i === s;
                rgba(C.edit, active ? 1 : 0.7);
                g.set_line_width(active ? 1.5 : 1);
                roundRect(x - spkR - 1.5, y - spkR - 1.5, 2 * spkR + 3, 2 * spkR + 3, 4);
                g.stroke();
                g.set_line_width(1);
            }
            rgba(C.ink);
            label(String(s + 1), x, y);
        });
    }

    // level of the selected source at each speaker, written towards the centre
    if (flags.draw_speakers && flags.draw_intensity && sel.length) {
        const stereo = sel.length === 2;
        spk.forEach((o, s) => {
            const [x, y] = toScreen(o.x, o.y);
            const lines = sel.map((gc, j) => (stereo ? (j === 0 ? "L " : "R ") : "") + fmtDb(gc[s]) + " dB");
            lines.forEach((str, j) => {
                const ty = y + 3 + (stereo ? (j === 0 ? -5 : 6) : 0);
                rgba(sel[j][s] > 1e-6 ? C.text : C.dim);
                if (x <= cx) text(str, x + spkR + 4, ty);
                else text(str, x - spkR - 4 - mgraphics.text_measure(str)[0], ty);
            });
        });
    }

    // sources (DBAP: rounded square knob, VBAP: circle knob); projection onto the hull
    if (flags.draw_sources) {
        src.forEach((o, k) => {
            const c = PALETTE[k % PALETTE.length];
            const active = drag && (drag.kind === "source" || drag.kind === "width" || drag.kind === "stereo") && drag.i === k;
            // stereo: link L and R through the centre
            if (o.stereo) {
                const [lx, ly] = toScreen(o.ch[0].x, o.ch[0].y);
                const [rx, ry] = toScreen(o.ch[1].x, o.ch[1].y);
                const [mx, my] = toScreen(o.x, o.y);
                rgba(c, 0.45);
                g.move_to(lx, ly);
                g.line_to(mx, my);
                g.line_to(rx, ry);
                g.stroke();
                circle(mx, my, 2);
                g.fill();
            }
            o.ch.forEach((ch, j) => {
                const [x, y] = toScreen(ch.x, ch.y);
                if (ch.hullDist > 0) {
                    const [px, py] = toScreen(ch.px, ch.py);
                    rgba(c, 0.5);
                    g.move_to(x, y);
                    g.line_to(px, py);
                    g.stroke();
                    circle(px, py, 2.5);
                    g.fill();
                }
                rgba(c);
                if (o.algorithm === DBAP) roundRect(x - knobR, y - knobR, 2 * knobR, 2 * knobR, 4);
                else circle(x, y, knobR);
                g.fill();
                if (active || k === selected) {
                    rgba(C.line, active ? 0.9 : 0.5);
                    g.set_line_width(active ? 1.5 : 1);
                    if (o.algorithm === DBAP) roundRect(x - knobR - 2.5, y - knobR - 2.5, 2 * knobR + 5, 2 * knobR + 5, 5);
                    else circle(x, y, knobR + 2.5);
                    g.stroke();
                    g.set_line_width(1);
                }
                rgba(C.ink);
                label(String(k + 1) + (o.stereo ? (j === 0 ? "L" : "R") : ""), x, y);
            });
        });
    }

    // overlays, anchored to the object's corners (outside the circle): algorithm of
    // the selected source top left (with the spread focus for VBAP), edit mode under
    // it, drag info bottom left, attenuation bottom right
    g.select_font_face(FONT_BOLD);
    if (selected >= 0 && selected < src.length) {
        rgba(C.text);
        text(src[selected].algorithm === DBAP ? "DBAP" : "VBAP  \u00b7  focus " + fmtFocus(spreadFocus), TEXT_INSET, TEXT_TOP);
    }
    if (flags.edit_speakers) {
        rgba(C.edit);
        text("EDIT SPEAKERS", TEXT_INSET, TEXT_TOP + 11);
    }
    g.select_font_face(FONT);
    const info = readout();
    if (info) {
        rgba(C.text);
        text(info, TEXT_INSET, h - TEXT_INSET);
    }
    const right = readoutRight();
    if (right) {
        rgba(C.text);
        text(right, w - TEXT_INSET - mgraphics.text_measure(right)[0], h - TEXT_INSET);
    }
}

// ================================================================ private helpers

// every top-level function is a message in Max; hide the internal ones
[
    clamp, clampToField, maxStereoWidth, stereoWidthAt, toNorm, fromNorm, wrap360, azOf, radiusOf, rolloffToA, polarToXY, ringDegrees, index, newSpeaker,
    newSource, newChannel, updateChannels, mirrorXY, rebuildLayout, cross, convexHull,
    projectOntoHull, fmtAz, fmtList, checkLayout, ensureGains, ensureAllGains, computeGains,
    addGroup, vbapPoint, computeVBAP, computeDBAP, invalidateAll, emitGains, perSource, pair,
    emitGeometry, changed, sourcePolar, speakerPolar, place, setSource, setSourceParam, unmirror, setSpeaker,
    setWeight, perItem, setFlag, toScreen, toWorld, hitSpeaker, hitChannel, reportSource, rgba,
    spreadExponent, spreadWeight, circle, roundRect, label, text, readout, readoutRight, haloRadius, fmtDb, fmtFocus, attenuation, clampDb, levelOf, mix,
].forEach(f => { f.local = 1; });

// ================================================================ init

(function init() {
    const args = typeof jsarguments !== "undefined" ? jsarguments : [];
    const ns = args.length > 1 ? Math.max(0, Math.floor(args[1])) : 8;
    const nk = args.length > 2 ? Math.max(0, Math.floor(args[2])) : 4;
    speaker_coords(...ringDegrees(ns));
    num_sources(nk);
})();
