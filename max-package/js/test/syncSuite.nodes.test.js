/**
 * Tests for syncSuite.nodes.js panning (VBAP + DBAP).
 *
 *   node max-package/js/test/syncSuite.nodes.test.js
 *
 * Loads the v8ui script with stubbed Max globals and checks it against
 * independent reference implementations:
 *   - VBAP: Pulkki's p^T L^-1 by explicit 2x2 matrix inversion
 *   - DBAP: line-by-line transcription of Jamoma j.dbap.cpp dbap_calculate2D
 * plus invariants (unit power, non-negative, finite), continuity sweeps,
 * convex hull projection vs brute force, and degenerate layouts.
 */

const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------- load script

function load() {
    const out = [];
    const posts = [];
    const g = {
        inlets: 0, outlets: 0,
        setinletassist() {}, setoutletassist() {},
        post: s => posts.push(s),
        outlet: (i, v) => out.push([i, ...v]),
        mgraphics: { init() {}, redraw() {}, size: [200, 200] },
        jsarguments: ["x", 0, 0],
    };
    const code = fs.readFileSync(path.join(__dirname, "..", "syncSuite.nodes.js"), "utf8");
    const api = new Function(...Object.keys(g), code + `
        return { speaker_coords, num_sources, algorithm, speaker, speaker_weight, source, source_xy, source_azimuth, source_distance,
                 get_source, output_source_position, setSource, bypass_ui,
                 sources_mode, stereo_width, source_stereo_width, spread_focus, mirror_sources, haloRadius,
                 attenuation, dbap_rolloff_: dbap_rolloff,
                 distance_attenuation, source_distance_attenuation,
                 source_spread, source_blur, dbap_rolloff, dbap_hull, vbap_center_blend,
                 get_gains, get_geometry, speaker_azimuth, speaker_distance, get_speakers, getvalueof, setvalueof, dump,
                 state: () => { ensureAllGains(); return { spk, src, gains, hull, sigma }; } };`)(...Object.values(g));
    api.out = out;
    api.posts = posts;
    return api;
}

// ---------------------------------------------------------------- tiny harness

let failures = 0;
let checks = 0;
function check(cond, msg) {
    checks++;
    if (!cond) {
        failures++;
        if (failures <= 25) console.log("  FAIL: " + msg);
    }
}
function close(a, b, tol = 1e-9) { return Math.abs(a - b) <= tol; }
function vecClose(a, b, tol = 1e-9) { return a.length === b.length && a.every((v, i) => close(v, b[i], tol)); }
function section(name) { console.log(name); }

// deterministic RNG
let seed = 12345;
function rnd() { seed = (seed * 1664525 + 1013904223) >>> 0; return seed / 4294967296; }

const RAD = Math.PI / 180;
const wrap360 = a => ((a % 360) + 360) % 360;
const azOf = (x, y) => Math.atan2(x - 0.5, 0.5 - y) / RAD;

// random point inside the circular field (radius 0.5 around 0.5, 0.5)
function rndIn(radius = 0.5) {
    for (;;) {
        const x = rnd() * 2 - 1, y = rnd() * 2 - 1;
        if (x * x + y * y <= 1) return [0.5 + x * radius, 0.5 + y * radius];
    }
}

function power(g) { return g.reduce((s, v) => s + v * v, 0); }

function sane(g, label) {
    check(g.every(v => Number.isFinite(v)), label + ": non-finite gain " + JSON.stringify(Array.from(g)));
    check(g.every(v => v >= -1e-12), label + ": negative gain " + JSON.stringify(Array.from(g)));
}

// speaker at an x/y position (the object itself takes azimuth + distance 0..1)
function spkXY(api, i, x, y) {
    api.speaker(i, Math.atan2(x - 0.5, 0.5 - y) / RAD, Math.hypot(x - 0.5, y - 0.5) / 0.5);   // distance: 1 = perimeter
}

// place speakers at arbitrary x/y
function layout(api, pts) {
    api.speaker_coords(...pts.map(() => 0));
    pts.forEach(([x, y], i) => spkXY(api, i + 1, x, y));
}

// ---------------------------------------------------------------- references

// Pulkki 2D VBAP: for each adjacent pair (aperture < 170), g = p^T L^-1,
// accept the pair where both gains >= 0; normalize to unit power.
function refVBAP(spkAz, phi) {
    const n = spkAz.length;
    if (n === 1) return [1];
    const order = spkAz.map((a, i) => i).sort((a, b) => wrap360(spkAz[a]) - wrap360(spkAz[b]));
    const u = a => [Math.sin(a * RAD), Math.cos(a * RAD)]; // any consistent unit vector
    const p = u(phi);
    for (let j = 0; j < n; j++) {
        const a = order[j], b = order[(j + 1) % n];
        const span = wrap360(spkAz[b] - spkAz[a]);
        if (span >= 170 || span < 1e-9) continue;
        const [l11, l12] = u(spkAz[a]);
        const [l21, l22] = u(spkAz[b]);
        const det = l11 * l22 - l12 * l21;
        // L = [[l11 l12], [l21 l22]] (rows = speaker vectors); g = p^T L^-1
        const g1 = (p[0] * l22 - p[1] * l21) / det;
        const g2 = (-p[0] * l12 + p[1] * l11) / det;
        if (g1 >= -1e-9 && g2 >= -1e-9) {
            const nrm = Math.hypot(g1, g2);
            const g = new Array(n).fill(0);
            g[a] = g1 / nrm;
            g[b] = g2 / nrm;
            return g;
        }
    }
    return null;
}

// Jamoma j.dbap.cpp dbap_calculate2D (without hull), transcribed
function refDBAP(spkPts, weights, sx, sy, blur, rolloff) {
    const N = spkPts.length;
    const a = Math.log(Math.pow(10, rolloff / 20)) / Math.log(2);
    let mx = 0, my = 0;
    spkPts.forEach(([x, y]) => { mx += x; my += y; });
    mx /= N; my /= N;
    let d2 = 0;
    spkPts.forEach(([x, y]) => { d2 += (x - mx) ** 2 + (y - my) ** 2; });
    const variance = Math.sqrt(d2 / (N - 1));
    let r2 = blur * variance;
    r2 = r2 * r2;
    let k2inv = 0;
    const dia = [];
    for (let i = 0; i < N; i++) {
        const dx = sx - spkPts[i][0];
        const dy = sy - spkPts[i][1];
        dia[i] = Math.pow(dx * dx + dy * dy + r2, 0.5 * a);
        k2inv += (weights[i] * weights[i]) / (dia[i] * dia[i]);
    }
    const k = Math.sqrt(1 / k2inv);
    return dia.map((d, i) => (weights[i] * k) / d);
}

// ================================================================ VBAP

section("VBAP: known values");
{
    const api = load();
    api.num_sources(1);
    api.vbap_center_blend(0);
    const g = () => Array.from(api.state().gains[0][0]);

    api.speaker_coords(-30, 30);
    api.source(1, 0, 0.4);
    check(vecClose(g(), [Math.SQRT1_2, Math.SQRT1_2]), "stereo +-30, centre -> equal");
    api.source(1, 30, 0.4);
    check(vecClose(g(), [0, 1]), "stereo +-30, at right speaker");
    api.source(1, -30, 0.4);
    check(vecClose(g(), [1, 0]), "stereo +-30, at left speaker");
    // tangent law check at 15 deg: (g1-g2)/(g1+g2) = tan(phi)/tan(phi0) with phi measured to the left
    api.source(1, -15, 0.4);
    const [gl, gr] = g();
    check(close((gl - gr) / (gl + gr), Math.tan(15 * RAD) / Math.tan(30 * RAD)), "tangent law at -15 deg");

    api.speaker_coords(-45, 45, 135, -135);
    api.source(1, 45, 0.4);
    check(vecClose(g(), [0, 1, 0, 0]), "quad at speaker 2");
    api.source(1, 180, 0.4);
    check(vecClose(g(), [0, 0, Math.SQRT1_2, Math.SQRT1_2]), "quad rear centre");
}

section("VBAP: random layouts vs p^T L^-1 reference");
{
    const api = load();
    api.num_sources(1);
    api.vbap_center_blend(0);
    let tested = 0;
    for (let trial = 0; trial < 400; trial++) {
        const n = 3 + Math.floor(rnd() * 14);
        const az = [];
        for (let i = 0; i < n; i++) az.push(rnd() * 360 - 180);
        // only layouts where every adjacent gap < 170 (pure VBAP domain)
        const sorted = az.map(wrap360).sort((a, b) => a - b);
        let ok = true;
        for (let i = 0; i < n; i++) {
            const gap = wrap360(sorted[(i + 1) % n] - sorted[i]);
            if (gap >= 170 || gap < 0.5) ok = false;
        }
        if (!ok) continue;
        api.speaker_coords(...az);
        for (let s = 0; s < 20; s++) {
            const phi = rnd() * 360 - 180;
            api.source(1, phi, 0.45);
            const got = Array.from(api.state().gains[0][0]);
            const ref = refVBAP(az, phi);
            check(ref && vecClose(got, ref, 1e-9), `n=${n} phi=${phi.toFixed(2)} got ${got.map(v => v.toFixed(4))} ref ${ref && ref.map(v => v.toFixed(4))}`);
            tested++;
        }
    }
    console.log("  " + tested + " source positions compared");
}

section("VBAP: continuity sweep, invariants, spread");
{
    const api = load();
    api.num_sources(1);
    const layouts = [[-30, 30], [-45, 45, 135, -135], [-30, 30, 0, 110, -110], [0, 90, 180, 270],
                     [-22.5, 22.5, 67.5, 112.5, 157.5, -157.5, -112.5, -67.5], [10], [0, 0, 0], [-60, 60, 180]];
    for (const L of layouts) {
        for (const centre of [0, 1]) {
            api.vbap_center_blend(centre);
            api.speaker_coords(...L);
            for (const spread of [0, 45, 120, 360]) {
                api.source_spread(1, spread / 360);
                let prev = null;
                let maxJump = 0;
                for (let a = -180; a <= 180; a += 0.25) {
                    api.source(1, a, 0.45);
                    const g = Array.from(api.state().gains[0][0]);
                    sane(g, `L=${L} spread=${spread} a=${a}`);
                    check(close(power(g), 1, 1e-9), `L=${L} spread=${spread} a=${a}: power ${power(g)}`);
                    if (prev) maxJump = Math.max(maxJump, ...g.map((v, i) => Math.abs(v - prev[i])));
                    prev = g;
                }
                // 0.25 deg steps: a continuous panner moves gains by far less than 0.1
                check(maxJump < 0.1, `L=${L} spread=${spread} centre=${centre}: discontinuity ${maxJump.toFixed(3)}`);
            }
        }
    }
    // spread symmetric around a speaker gives symmetric neighbours
    api.vbap_center_blend(0);
    api.speaker_coords(-90, -45, 0, 45, 90, 135, 180, -135);
    api.source_spread(1, 0.25);
    api.source(1, 0, 0.45);
    const g = Array.from(api.state().gains[0][0]);
    check(close(g[1], g[3], 1e-12) && g[2] > g[1], "spread 90 at a speaker is symmetric");
    // radial path through the centre is continuous with center spread on
    api.vbap_center_blend(1);
    api.source_spread(1, 0);
    let prev = null, maxJump = 0;
    for (let y = 0.05; y <= 0.95; y += 0.001) {
        api.source_xy(1, 0.5, y);
        const gg = Array.from(api.state().gains[0][0]);
        if (prev) maxJump = Math.max(maxJump, ...gg.map((v, i) => Math.abs(v - prev[i])));
        prev = gg;
    }
    check(maxJump < 0.05, "crossing the centre is continuous with vbap_center_blend 1 (" + maxJump.toFixed(4) + ")");
    api.source_xy(1, 0.5, 0.5);
    const gc = Array.from(api.state().gains[0][0]);
    check(gc.every(v => close(v, gc[0], 1e-9)), "source at centre -> all speakers equal");
}


section("VBAP: groups, centre blend, MDAP smoothness");
{
    const api = load();
    api.num_sources(1);
    api.vbap_center_blend(0);
    const g = () => Array.from(api.state().gains[0][0]);
    // coincident speakers share equally
    api.speaker_coords(-30, 30, 30);
    api.source(1, 30, 0.45);
    check(vecClose(g(), [0, Math.SQRT1_2, Math.SQRT1_2]), "two speakers at 30 deg share equally");
    api.source(1, 0, 0.45);
    const h = g();
    check(close(h[1], h[2]) && close(h[0] * h[0], h[1] * h[1] + h[2] * h[2]), "pair with a coincident group: group power = other side");
    // centre is exactly omni for an irregular layout
    api.vbap_center_blend(1);
    api.speaker_coords(-30, 30, 0, 110, -110);
    api.source_xy(1, 0.5, 0.5);
    check(g().every(v => close(v, 1 / Math.sqrt(5), 1e-12)), "5.0, centre -> 1/sqrt(5) each");
    // on the ring (the perimeter) the blend is off: pure VBAP
    api.source(1, 15, 1);
    check(vecClose(g(), refVBAP([-30, 30, 0, 110, -110], 15)), "on the ring -> pure VBAP");
    // spread (1 deg sampling) vs an independent 0.05 deg bell-weighted sum of the reference VBAP
    api.vbap_center_blend(0);
    const bellP = sp => { const h = 180 * Math.pow(sp, 1.6); return h >= 180 - 1e-9 ? 0 : Math.log(0.5) / Math.log((1 + Math.cos(h * RAD)) / 2); };
    let worst = 0;
    for (const L of [[0, 45, 90, 135, 180, 225, 270, 315], [-30, 30, 0, 110, -110], [-45, 45, 135, -135]]) {
        api.speaker_coords(...L);
        for (const sp of [0.1, 0.3, 0.5, 0.7, 0.9]) {
            api.source_spread(1, sp);
            const p = bellP(sp);
            for (let a = -180; a < 180; a += 37) {
                api.source(1, a, 1);
                const acc = new Array(L.length).fill(0);
                for (let k = -180; k < 180; k += 0.05) {
                    const w = Math.pow((1 + Math.cos(k * RAD)) / 2, p);
                    if (w < 1e-9) continue;
                    refVBAP(L, a + k).forEach((v, j) => { acc[j] += v * w; });
                }
                const nrm = Math.hypot(...acc);
                const e = Math.pow(sp, 8);
                const ref = acc.map(v => Math.sqrt((1 - e) * (v / nrm) ** 2 + e / L.length));
                const got = g();
                worst = Math.max(worst, ...got.map((v, j) => Math.abs(v - ref[j])));
            }
        }
    }
    check(worst < 2e-3, "spread: 1 deg sampling vs 0.05 deg bell reference, worst error " + worst);
    console.log("  spread worst error vs fine reference: " + worst.toExponential(2));

    // what spread promises
    api.speaker_coords(-30, 30, 0, 110, -110);          // irregular
    api.source(1, 17, 1);
    api.source_spread(1, 1);
    check(g().every(v => close(v, 1 / Math.sqrt(5), 1e-12)), "spread 1: every speaker equal, even on 5.0");
    api.speaker_coords(0, 45, 90, 135, 180, 225, 270, 315);
    api.source(1, 0, 1);
    api.source_spread(1, 0.5);
    const hs = g();
    check(hs[0] > hs[1] && close(hs[1], hs[7]) && hs[1] > hs[2] && hs[2] > hs[3] && hs[3] >= hs[4] - 1e-12,
          "spread 0.5: level falls off with angle from the source (no flat top)");
    check(close(20 * Math.log10(hs[0] / hs[1]), 3, 0.05), "spread 0.5: speakers 45 deg away are 3 dB below the pointed-at one (" + (20 * Math.log10(hs[0] / hs[1])).toFixed(2) + " dB)");
    api.source_spread(1, 0.001);
    const tiny = g();
    api.source_spread(1, 0);
    check(vecClose(tiny, g(), 1e-3), "tiny spread = plain VBAP");
    let prevS = null, jumpS = 0;
    for (let sp = 0; sp <= 1.0000001; sp += 0.005) {
        api.source_spread(1, Math.min(sp, 1));
        const v = g();
        if (prevS) jumpS = Math.max(jumpS, ...v.map((x, i) => Math.abs(x - prevS[i])));
        prevS = v;
    }
    check(jumpS < 0.05, "gains change smoothly as spread goes 0 -> 1 (max step " + jumpS.toFixed(4) + ")");
}

// ================================================================ DBAP

section("DBAP: random layouts vs Jamoma j.dbap reference (hull off)");
{
    const api = load();
    api.num_sources(1);
    api.algorithm(1, 1);
    api.dbap_hull(0);
    let tested = 0;
    for (let trial = 0; trial < 300; trial++) {
        const n = 2 + Math.floor(rnd() * 15);
        const pts = [];
        for (let i = 0; i < n; i++) pts.push(rndIn());
        const weights = pts.map(() => (rnd() < 0.2 ? 0 : 0.1 + rnd() * 2));
        if (weights.every(w => w === 0)) weights[0] = 1;
        const rolloff = [6, 3, 4.5, 12, 1][trial % 5];
        layout(api, pts);
        weights.forEach((w, i) => api.speaker_weight(i + 1, w));
        api.dbap_rolloff(rolloff);
        for (let s = 0; s < 10; s++) {
            const blur = [0.000001, 0.1, 0.5, 2][s % 4];
            const [sx, sy] = rndIn();
            api.source_blur(1, blur);
            api.source_xy(1, sx, sy);
            const got = Array.from(api.state().gains[0][0]);
            const ref = refDBAP(pts, weights, sx, sy, blur, rolloff);
            check(vecClose(got, ref, 1e-9), `n=${n} R=${rolloff} blur=${blur} got ${got.map(v => v.toFixed(5))} ref ${ref.map(v => v.toFixed(5))}`);
            sane(got, "dbap random");
            check(close(power(got), 1, 1e-9), "dbap power " + power(got));
            tested++;
        }
    }
    console.log("  " + tested + " source positions compared");
}

section("DBAP: paper identities");
{
    const api = load();
    api.num_sources(1);
    api.algorithm(1);
    api.dbap_hull(0);
    const g = () => Array.from(api.state().gains[0][0]);

    // eq. 4: a = R / (20 log10 2); relative levels v_i/v_j = (d_j/d_i)^a
    const pts = [[0.2, 0.2], [0.8, 0.3], [0.5, 0.9], [0.1, 0.7]];
    layout(api, pts);
    api.source_blur(1, 0);
    for (const R of [6, 3]) {
        api.dbap_rolloff(R);
        api.source_xy(1, 0.4, 0.45);
        const v = g();
        const a = R / (20 * Math.log10(2));
        const d = pts.map(([x, y]) => Math.hypot(x - 0.4, y - 0.45));
        check(close(v[0] / v[1], Math.pow(d[1] / d[0], a), 1e-9), `R=${R}: v0/v1 = (d1/d0)^a`);
    }
    // R = 6 dB: doubling the distance ~ halves the amplitude (-6.02 dB exactly at a = 1)
    api.dbap_rolloff(20 * Math.log10(2));
    api.source_xy(1, 0.4, 0.45);
    const v = g();
    const d = pts.map(([x, y]) => Math.hypot(x - 0.4, y - 0.45));
    check(close(v[0] * d[0], v[2] * d[2], 1e-9), "a = 1: v_i * d_i constant (inverse distance)");

    // eq. 7: source exactly on a speaker, no blur -> that speaker only
    api.dbap_rolloff(6);
    api.source_xy(1, 0.8, 0.3);
    check(vecClose(g(), [0, 1, 0, 0]), "on speaker 2 with blur 0 -> [0 1 0 0]");
    // and continuous towards it
    api.source_xy(1, 0.8 + 1e-7, 0.3);
    check(g()[1] > 0.999, "approaching speaker 2 -> gain -> 1");

    // weight 0 silences a speaker, eq. 9-10 keep unit power
    api.speaker_weight(3, 0);
    api.source_xy(1, 0.5, 0.8);
    check(g()[2] === 0 && close(power(g()), 1), "weight 0 -> speaker silent, power 1");
    api.speaker_weight(0);
    api.source_xy(1, 0.3, 0.3);
    check(g().every(x => x === 0), "all weights 0 -> all gains 0, no NaN");
    api.speaker_weight(1);

    // symmetric layout, source at the centre -> equal gains
    api.speaker_coords(-45, 45, 135, -135);
    api.source_xy(1, 0.5, 0.5);
    const e = g();
    check(e.every(x => close(x, 0.5, 1e-12)), "quad, centre -> 0.5 each");

    // blur makes it more even: max gain decreases monotonically with blur
    api.source_xy(1, 0.25, 0.3);
    let last = 2;
    let mono = true;
    for (const b of [0, 0.1, 0.3, 1, 3]) {
        api.source_blur(1, b);
        const m = Math.max(...g());
        if (m > last + 1e-12) mono = false;
        last = m;
    }
    check(mono, "more blur -> flatter distribution");
}

section("DBAP: convex hull projection vs brute force");
{
    const api = load();
    api.num_sources(1);
    api.algorithm(1);
    api.dbap_hull(1);
    for (let trial = 0; trial < 200; trial++) {
        const n = 1 + Math.floor(rnd() * 10);
        const pts = [];
        for (let i = 0; i < n; i++) pts.push([0.2 + 0.6 * rnd(), 0.2 + 0.6 * rnd()]);
        if (trial % 10 === 0 && n >= 3) pts.forEach((p, i) => { p[1] = 0.3 + 0.1 * p[0]; }); // collinear
        layout(api, pts);
        const { spk, hull } = api.state();
        // brute-force hull check: every speaker on the inner side of every hull edge
        if (hull.length >= 3) {
            for (let j = 0; j < hull.length; j++) {
                const a = spk[hull[j]], b = spk[hull[(j + 1) % hull.length]];
                for (const p of spk) {
                    const c = (b.x - a.x) * (p.y - a.y) - (b.y - a.y) * (p.x - a.x);
                    check(c >= -1e-12, "speaker outside hull edge");
                }
            }
        }
        for (let s = 0; s < 10; s++) {
            const [sx, sy] = rndIn();
            api.source_xy(1, sx, sy);
            const o = api.state().src[0].ch[0];
            // brute force nearest point on the hull polygon boundary
            let best = Infinity, bx = sx, by = sy;
            const m = hull.length;
            for (let j = 0; j < Math.max(1, m); j++) {
                const a = spk[hull[j]], b = spk[hull[(j + 1) % m]];
                for (let t = 0; t <= 1; t += 1 / 2000) {
                    const qx = a.x + t * (b.x - a.x), qy = a.y + t * (b.y - a.y);
                    const d = Math.hypot(sx - qx, sy - qy);
                    if (d < best) { best = d; bx = qx; by = qy; }
                }
            }
            // ray-casting inside test (strict interior)
            let inside = false;
            if (m >= 3) {
                for (let i = 0, j = m - 1; i < m; j = i++) {
                    const a = spk[hull[i]], b = spk[hull[j]];
                    if ((a.y > sy) !== (b.y > sy) && sx < ((b.x - a.x) * (sy - a.y)) / (b.y - a.y) + a.x) inside = !inside;
                }
            }
            if (inside) {
                check(o.hullDist === 0 && o.px === sx && o.py === sy, "inside hull -> not projected");
            } else {
                check(close(o.hullDist, best, 2e-3), `hull distance ${o.hullDist} vs brute ${best}`);
                check(Math.hypot(o.px - bx, o.py - by) < 2e-3, "projection point matches brute force");
                // gains equal DBAP at the projected point
                const ref = refDBAP(pts.length > 1 ? pts : [pts[0], pts[0]], pts.length > 1 ? pts.map(() => 1) : [1, 0],
                                    o.px, o.py, 0.000001, 6).slice(0, pts.length);
                if (pts.length > 1) check(vecClose(Array.from(api.state().gains[0][0]), ref, 1e-4), "gains = DBAP at projection");
            }
            sane(Array.from(api.state().gains[0][0]), "hull");
        }
    }
    // hull_distance message
    layout(api, [[0.2, 0.2], [0.8, 0.2], [0.8, 0.8], [0.2, 0.8]]);
    api.source_xy(1, 0.5, 0.05);
    api.out.length = 0;
    api.get_gains();
    const msg = api.out.find(m => m[0] === 1 && m[1] === "hull_distance");
    check(msg && msg[2] === 1 && msg[3] === 1 && close(msg[4], 0.15, 1e-12), "hull_distance 1 1 0.15 is output");
}

// ================================================================ degenerate / fuzz

section("Fuzz: degenerate layouts, both algorithms");
{
    const api = load();
    api.num_sources(3);
    const layouts = [
        [[0.5, 0.5]],
        [[0.5, 0.5], [0.5, 0.5]],
        [[0.3, 0.3], [0.3, 0.3], [0.7, 0.7]],
        [[0.1, 0.5], [0.5, 0.5], [0.9, 0.5]],
        [[0.5, 0.5], [0.9, 0.5]],
        [[0.15, 0.15], [0.85, 0.15], [0.85, 0.85], [0.15, 0.85]],
    ];
    for (const L of layouts) {
        layout(api, L);
        for (const alg of [0, 1]) {
            api.algorithm(alg);
            for (const hullOn of [0, 1]) {
                api.dbap_hull(hullOn);
                for (let s = 0; s < 200; s++) {
                    api.source_spread(1, rnd());
                    api.source_blur(1, rnd() < 0.5 ? 0 : rnd() * 3);
                    const [rx, ry] = rndIn();
                    const sx = rnd() < 0.2 ? L[0][0] : rx;
                    const sy = rnd() < 0.2 ? L[0][1] : ry;
                    api.source_xy(1, sx, sy);
                    const g = Array.from(api.state().gains[0][0]);
                    sane(g, `alg=${alg} L=${JSON.stringify(L)} src=${sx},${sy}`);
                    check(close(power(g), 1, 1e-9), `alg=${alg} L=${JSON.stringify(L)} src=${sx},${sy}: power ${power(g)}`);
                }
            }
        }
    }
    // zero speakers: no crash, empty gains
    api.speaker_coords();
    api.source_xy(1, 0.3, 0.3);
    check(api.state().gains[0][0].length === 0, "no speakers -> empty gain list");
}


section("Output only on request");
{
    const api = load();
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(3);
    api.out.length = 0;
    api.source_xy(1, 0.2, 0.3);
    spkXY(api, 2, 0.9, 0.2);
    api.source_spread(0.25);
    api.algorithm(2, 1);
    api.dbap_rolloff(4);
    check(api.out.length === 0, "no output from inlet messages (" + api.out.length + ")");
    api.get_gains();
    check(api.out.length === 4 && api.out.filter(m => m[0] === 0).length === 3, "get_gains: 3 gain lists + 1 hull_distance");
    check(api.out.filter(m => m[0] === 0).every((m, i) => m[1] === i + 1 && m[2] === 1 && m.length === 3 + 4), "gain list = <source> <channel> + 4 gains");
    api.out.length = 0;
    api.get_gains(3);
    check(api.out.length === 1 && api.out[0][1] === 3, "get_gains 3 -> only source 3");
    api.out.length = 0;
    api.get_geometry(1);
    check(api.out.length === 4 && api.out.every(m => m[0] === 1 && m[1] === 1), "get_geometry 1 -> 4 pairs");
}

section("VBAP layout warnings");
{
    const api = load();
    const warn = () => { const w = api.posts.filter(p => p.includes("VBAP warning")); api.posts.length = 0; return w; };
    api.speaker_coords(...[-22.5, 22.5, 67.5, 112.5, 157.5, -157.5, -112.5, -67.5]);
    api.num_sources(2);
    check(warn().length === 0, "regular octagon -> no warnings");

    api.speaker_coords(-30, 30);
    let w = warn();
    check(w.length === 1 && w[0].includes("300.0") && w[0].includes("crossfaded"), "stereo +-30: one gap warning");
    api.speaker_coords(-30, 30);
    check(warn().length === 0, "same problem again -> not repeated");
    for (let x = 0.7; x < 0.8; x += 0.01) spkXY(api, 2, x, 0.2);
    check(warn().length === 0, "dragging within the same problem -> not repeated");

    {
        const fresh = load();
        fresh.num_sources(1);
        fresh.posts.length = 0;
        fresh.speaker_coords(-90, 90);
        const fw = fresh.posts.filter(p => p.includes("VBAP warning"));
        check(fw.length === 2 && fw.every(x => x.includes("180.0")) && fw[0] !== fw[1], "stereo +-90: two distinct 180 deg gaps");
    }

    api.speaker_coords(-45, 45, 45, 135, -135);
    w = warn();
    check(w.length === 1 && w[0].includes("speakers 2, 3") && w[0].includes("\u221a2"), "coincident speakers warning");

    api.speaker_coords(-45, 45, 135, -135);
    spkXY(api, 4, 0.5, 0.5);
    w = warn();
    check(w.some(x => x.includes("speaker 4 sits on the centre")), "speaker at centre warning");

    api.speaker_coords(-45, 45, 135, -135);
    warn();
    api.speaker(1, -45, 0.2);
    w = warn();
    check(w.some(x => x.includes("speaker 1 is at distance")), "unequal distance warning");

    api.speaker_coords(0);
    w = warn();
    check(w.length === 1 && w[0].includes("only one speaker"), "single speaker warning");

    api.algorithm(1);
    api.speaker_coords(-30, 30);
    check(warn().length === 0, "all sources DBAP -> no VBAP warnings");
    api.algorithm(1, 0);
    check(warn().length === 1, "switching a source back to VBAP -> warning posted again");
}


section("Speaker index = position in the speakers list (never re-sorted)");
{
    const api = load();
    api.num_sources(1);
    api.vbap_center_blend(0);
    const g = () => Array.from(api.state().gains[0][0]);
    // deliberately not clockwise
    api.speaker_coords(90, -90, 0, 180, 45);
    const expect = { 90: 0, "-90": 1, 0: 2, 180: 3, 45: 4 };
    for (const [az, idx] of Object.entries(expect)) {
        for (const alg of [0, 1]) {
            api.algorithm(1, alg);
            api.source_blur(1, 0);
            api.dbap_hull(0);
            api.source(1, +az, 1);
            const v = g();
            check(v[idx] > 0.999 && v.every((x, i) => i === idx || x < 1e-6),
                  `alg ${alg}: source at ${az} deg -> only speaker ${idx + 1} (got ${v.map(x => x.toFixed(3))})`);
        }
    }
    api.algorithm(1, 0);
    // between list-speakers 3 (0 deg) and 5 (45 deg): only indices 2 and 4 sound
    api.source(1, 22.5, 1);
    const v = g();
    check(close(v[2], Math.SQRT1_2) && close(v[4], Math.SQRT1_2) && v[0] + v[1] + v[3] < 1e-9, "22.5 deg -> speakers 3 and 5 only");
    // get_gains keeps list order, get_speakers too
    api.out.length = 0;
    api.get_gains(1);
    check(vecClose(api.out[0].slice(3), v), "get_gains outputs gains in list order");
    const s = api.state().spk;
    check(close(s[0].x, 1) && close(s[1].x, 0) && close(s[3].y, 1), "speaker i is placed at the i-th azimuth, on the perimeter");
    // moving one speaker via "speaker i" does not change anyone's index
    spkXY(api, 2, 0.5, 0.05); // speaker 2 to the front
    api.source(1, 0, 0.45);
    const w = g();
    check(w[1] > 0.6 && w[2] > 0.6 && close(w[1], w[2]), "speaker 2 moved onto speaker 3's azimuth: both indices keep their own gain");
}


section("Source messages, lazy computation, output_source_position");
{
    const api = load();
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(2);
    // source <i> <az> <dist>
    api.source(1, 90, 0.6);
    let o = api.state().src[0];
    check(close(o.x, 0.8) && close(o.y, 0.5), "source 1 90 0.6 -> x 0.8 y 0.5");
    api.out.length = 0;
    api.get_source(1);
    check(api.out.length === 1 && api.out[0][1] === "source" && api.out[0][2] === 1
          && close(api.out[0][3], 90) && close(api.out[0][4], 0.6), "get_source 1 -> source 1 90 0.6");
    api.out.length = 0;
    api.get_source();
    check(api.out.length === 2, "get_source -> all sources");
    // round trip: what get_source prints is a valid source message
    const [, , i, az, d] = api.out[1];
    const before = [api.state().src[1].x, api.state().src[1].y];
    api.source(i, az, d);
    check(close(api.state().src[1].x, before[0]) && close(api.state().src[1].y, before[1]), "get_source output round-trips");
    // azimuth / distance separately
    api.source_azimuth(1, 180);
    o = api.state().src[0];
    check(close(o.x, 0.5) && close(o.y, 0.8), "source_azimuth keeps distance");
    api.source_distance(1, 0.2);
    o = api.state().src[0];
    check(close(o.x, 0.5) && close(o.y, 0.6), "source_distance keeps azimuth");
    // beyond the field: azimuth kept, distance shortened to the edge
    api.source(1, 30, 2);
    api.out.length = 0;
    api.get_source(1);
    check(close(api.out[0][3], 30, 1e-9) && close(api.out[0][4], 1, 1e-9), "distance 2 -> clamped to the perimeter (1), azimuth kept");
    api.source(1, -135, 5);
    api.out.length = 0;
    api.get_source(1);
    check(close(api.out[0][3], -135, 1e-9) && close(api.out[0][4], 1, 1e-9), "distance 5 at -135 -> on the perimeter, no corners");
    api.source_xy(1, 0, 0);
    check(close(Math.hypot(api.state().src[0].x - 0.5, api.state().src[0].y - 0.5), 0.5), "source_xy in a corner -> pulled onto the circle");
    // moving sources computes nothing and outputs nothing
    const st = api.state();
    api.out.length = 0;
    for (let n = 0; n < 1000; n++) api.source(1, n, 0.3);
    check(api.out.length === 0, "1000 moves -> no output");
    check(st.src[0].dirty === true, "moves only mark the source dirty");
    // mouse moves are silent unless output_source_position 1 (simulated through setSource)
    api.out.length = 0;
    api.setSource(0, 0.2, 0.2, true);          // what a mouse drag does
    check(api.out.length === 0, "mouse move silent by default");
    api.output_source_position(1);
    api.setSource(0, 0.8, 0.5, true);
    check(api.out.length === 1 && api.out[0][1] === "source" && close(api.out[0][3], 90) && close(api.out[0][4], 0.6),
          "output_source_position 1 -> mouse move reports source 1 90 0.6");
    api.out.length = 0;
    api.source(1, 0, 0.2);
    check(api.out.length === 0, "inlet messages never echo, even with output_source_position 1");
}


section("bypass_ui 1: drawing stops, everything else keeps working");
{
    const run = bypass => {
        const api = load();
        api.speaker_coords(-30, 30, 0, 110, -110);
        api.num_sources(3);
        if (bypass) api.bypass_ui(1);
        api.algorithm(3, 1);
        api.source(1, 20, 0.4);
        api.source_spread(2, 60 / 360);
        api.source(2, -120, 0.35);
        api.source_blur(3, 0.3);
        api.source(3, 150, 0.6);
        spkXY(api, 4, 0.9, 0.7);
        api.out.length = 0;
        api.get_gains();
        return api.out.map(m => m.slice());
    };
    const on = run(0), off = run(1);
    check(off.length === on.length && off.every((m, i) => m.every((v, j) => typeof v === "string" ? v === on[i][j] : close(v, on[i][j], 1e-15))),
          "get_gains with bypass_ui 1 == get_gains with the UI on");
}


section("Stereo sources");
{
    const api = load();
    api.speaker_coords(...[0, 45, 90, 135, 180, 225, 270, 315]);
    api.num_sources(2);
    const G = k => api.state().gains[k].map(a => Array.from(a));
    // reference: a mono source placed where each channel should be
    const monoAt = (az, dist, spread = 0) => {
        const r = load();
        r.speaker_coords(...[0, 45, 90, 135, 180, 225, 270, 315]);
        r.num_sources(1);
        r.source_spread(1, spread / 360);
        r.source(1, az, dist);
        return Array.from(r.state().gains[0][0]);
    };
    api.source(1, 20, 1);                        // full distance: full width
    check(G(0).length === 1, "mono by default: one channel");
    api.sources_mode(1, 0);
    let g = G(0);
    check(g.length === 2 && G(1).length === 1, "sources_mode 1 0 -> source 1 stereo, source 2 mono");
    check(vecClose(g[0], monoAt(-10, 1)) && vecClose(g[1], monoAt(50, 1)), "full distance: L at az - 30, R at az + 30 (default max 60)");
    check(g.every(c => close(power(c), 1)), "each channel unit power");
    // width scales with distance
    api.source(1, 20, 0.5);
    g = G(0);
    check(vecClose(g[0], monoAt(5, 0.5)) && vecClose(g[1], monoAt(35, 0.5)), "distance 0.5: half the width (L -15, R +15)");
    api.source(1, 20, 0);
    g = G(0);
    check(vecClose(g[0], g[1]), "centre: L and R meet");
    api.source(1, 20, 1);
    // per-source maximum
    api.source_stereo_width(1, 90);
    api.source_spread(1, 40 / 360);
    g = G(0);
    check(vecClose(g[0], monoAt(-25, 1, 40)) && vecClose(g[1], monoAt(65, 1, 40)), "source_stereo_width 90 + spread 40 per channel");
    api.source_stereo_width(1, 0);
    api.source_spread(1, 0);
    g = G(0);
    check(vecClose(g[0], g[1]) && vecClose(g[0], monoAt(20, 1)), "width 0 -> L = R = mono");
    // global maximum, override kept, override cleared
    api.source_stereo_width(1);                  // back to the global maximum
    api.stereo_width(120);
    g = G(0);
    check(vecClose(g[0], monoAt(-40, 1)) && vecClose(g[1], monoAt(80, 1)), "stereo_width 120 (global): L -60, R +60 around 20");
    api.sources_mode(1, 1);
    api.source(2, 0, 1);
    api.source_stereo_width(2, 30);
    check(vecClose(G(1)[0], monoAt(-15, 1)), "source_stereo_width 2 30 overrides the global 120");
    api.stereo_width(10);
    check(vecClose(G(1)[0], monoAt(-5, 1)) && vecClose(G(0)[0], monoAt(15, 1)), "stereo_width 10 resets every source, including source 2's own 30");
    api.source_stereo_width(2, 50);
    check(vecClose(G(1)[0], monoAt(-25, 1)) && vecClose(G(0)[0], monoAt(15, 1)), "then source_stereo_width 2 50 overrides again (source 1 stays at 10)");
    api.posts.length = 0;
    api.stereo_width(1, 60);
    check(api.posts.length === 1, "stereo_width with an index is refused with a hint");
    api.sources_mode(1, 0);
    // output format
    api.stereo_width(60);
    api.out.length = 0;
    api.get_gains();
    const rows = api.out.filter(m => m[0] === 0).map(m => m.slice(1, 3).join(":"));
    check(rows.join(" ") === "1:1 1:2 2:1", "get_gains -> 1:1 (L) 1:2 (R) 2:1 (mono), got " + rows.join(" "));
    // back to mono
    api.sources_mode(0, 0);
    check(G(0).length === 1, "sources_mode 0 0 -> mono again");
    api.sources_mode(0, 1);
    check(G(0).length === 1 && G(1).length === 2, "sources_mode 0 1 -> second source stereo");
    api.sources_mode(1);
    check(G(0).length === 2 && G(1).length === 2, "shorter list: sources beyond it keep their mode");
    api.posts.length = 0;
    api.sources_mode(1, 1, 1, 0);
    check(api.posts.length === 1 && G(0).length === 2 && G(1).length === 2, "extra flags ignored with a message");
    // DBAP stereo channels
    api.algorithm(1, 1);
    g = G(0);
    check(g.length === 2 && g.every(c => close(power(c), 1)), "DBAP stereo: two unit-power channels");
    // centre: both channels at the centre, fine
    api.algorithm(1, 0);
    api.source(1, 0, 0);
    g = G(0);
    check(g.every(c => c.every(v => close(v, 1 / Math.sqrt(8), 1e-12))), "stereo at the centre -> both omni");
}

section("Mirrored sources");
{
    const api = load();
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(4);
    const pol = k => { api.out.length = 0; api.get_source(k); return api.out[0].slice(3); };
    api.source(1, 40, 0.3);
    api.mirror_sources(1, 2);
    let p = pol(2);
    check(close(p[0], -40) && close(p[1], 0.3), "mirror lr: partner jumps to -40");
    for (const a of [0, 30, 100, 170, -120]) {
        api.source(1, a, 0.25);
        p = pol(2);
        check(close(p[0], -a, 1e-9) || close(Math.abs(p[0]), 180, 1e-9) && close(Math.abs(a), 180, 1e-9), "lr: 1 at " + a + " -> 2 at " + p[0]);
        check(close(p[1], 0.25, 1e-12), "lr keeps distance");
    }
    // moving the partner moves the leader
    api.source(2, 60, 0.2);
    p = pol(1);
    check(close(p[0], -60) && close(p[1], 0.2), "moving source 2 mirrors source 1");
    // opposite rotation: 1 goes clockwise, 2 goes counter-clockwise
    api.source(1, 10, 0.3);
    const a0 = pol(2)[0];
    api.source(1, 20, 0.3);
    check(pol(2)[0] < a0, "1 clockwise -> 2 counter-clockwise");
    // fb and point
    api.mirror_sources(3, 4, "fb");
    api.source(3, 30, 0.3);
    p = pol(4);
    check(close(p[0], 150) && close(p[1], 0.3), "fb: 30 -> 150");
    api.mirror_sources(3, 4, "point");
    api.source(3, 30, 0.3);
    p = pol(4);
    check(close(p[0], -150) && close(p[1], 0.3), "point: 30 -> -150 (210)");
    // relinking 1 with 3 unlinks 1-2 and 3-4
    api.mirror_sources(1, 3);
    const before2 = pol(2), before4 = pol(4);
    api.source(1, 77, 0.3);
    check(vecClose(pol(2), before2) && vecClose(pol(4), before4), "old partners are released");
    check(close(pol(3)[0], -77), "new pair works");
    // unlink one, unlink all
    api.mirror_sources(3);
    api.source(1, 5, 0.3);
    check(close(pol(3)[0], -77), "mirror_sources 3 unlinks");
    api.mirror_sources(1, 2);
    api.mirror_sources();
    api.source(1, 15, 0.3);
    check(!close(pol(2)[0], -15), "mirror_sources (no args) unlinks all");
    // self and bad mode rejected
    api.posts.length = 0;
    api.mirror_sources(1, 1);
    api.mirror_sources(1, 2, "sideways");
    check(api.posts.length === 2, "self-mirror and unknown mode are rejected with a message");
    // shrinking sources drops dangling links
    api.mirror_sources(1, 4);
    api.num_sources(3);
    api.source(1, 33, 0.3);
    check(api.state().src[0].mirror === -1, "num_sources below a partner drops the link");
    // mouse output reports both when enabled
    api.mirror_sources(1, 2);
    api.output_source_position(1);
    api.out.length = 0;
    api.setSource(0, 0.3, 0.3, true);
    check(api.out.length === 2 && api.out[0][2] === 1 && api.out[1][2] === 2, "mouse move reports source and mirror");
}


section("Spread / blur halo size");
{
    const api = load();
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(1);
    const o = () => api.state().src[0];
    check(api.haloRadius(o(), 300) === 0, "spread 0 -> no halo");
    api.source_spread(1, 1);
    check(close(api.haloRadius(o(), 300), 8 + 6 + 0.06 * 300), "spread 1 -> knob + 6 + 6% of the field (kept small)");
    api.source_spread(1, 0.25);
    const r90 = api.haloRadius(o(), 300);
    api.source_spread(1, 0.5);
    check(api.haloRadius(o(), 300) > r90, "halo grows with spread");
    api.algorithm(1, 1);
    api.source_blur(1, 0);
    check(api.haloRadius(o(), 300) === 0, "DBAP blur 0 -> no halo");
    api.source_blur(1, 1);
    check(close(api.haloRadius(o(), 300), Math.max(11, api.state().sigma * 300)), "DBAP halo = r_s = blur * sigma");
}


section("Drawing runs without errors (mock mgraphics), selection");
{
    const clicks = [];
    const texts = [];
    const calls = [];
    const mg = new Proxy({ size: [300, 300] }, {
        get: (o, k) => k in o ? o[k] : k === "text_measure" ? () => [20, 9]
            : k === "show_text" ? (t) => { calls.push(k); texts.push(t); } : (...a) => { calls.push(k); },
        set: (o, k, v) => { o[k] = v; return true; },
    });
    const g = {
        inlets: 0, outlets: 0, setinletassist() {}, setoutletassist() {}, post() {}, outlet: (i, v) => clicks.push([i, ...v]),
        mgraphics: mg, jsarguments: ["x", 0, 0],
    };
    const code = fs.readFileSync(path.join(__dirname, "..", "syncSuite.nodes.js"), "utf8");
    const api = new Function(...Object.keys(g), code + `
        return { paint, onclick, ondrag, output_source_position, distance_attenuation, speaker_coords, num_sources, sources_mode, algorithm, source, source_spread,
                 source_blur, mirror_sources, select_source, fmtDb, edit_speakers, draw_distance, draw_spread,
                 draw_sources, draw_speakers, draw_intensity, bypass_ui, speaker_size, source_size,
                 readout, readoutRight, levelOf, haloRadius, distance_attenuation, stereo_width, source_stereo_width,
                 spreadWeight, spread_focus, srcs: () => src, sel: () => selected };`)(...Object.values(g));
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(3);
    api.sources_mode(0, 1, 0);
    api.algorithm(3, 1);
    api.source_spread(1, 0.25);
    api.source_blur(3, 0.5);
    api.source(3, 30, 0.7);
    let errors = 0;
    for (let m = 0; m < 128; m++) {
        api.draw_distance(m & 1); api.draw_spread(m & 2); api.draw_sources(m & 4); api.draw_speakers(m & 8);
        api.draw_intensity(m & 16); api.edit_speakers(m & 32); api.bypass_ui(m & 64);
        try { api.paint(); } catch (e) { errors++; if (errors < 3) console.log("  paint error:", e.message); }
    }
    check(errors === 0, "paint() runs for all 128 flag combinations");
    // sizes
    api.speaker_size(30); api.source_size(40);
    try { api.paint(); } catch (e) { errors++; }
    check(errors === 0, "paint() runs with custom sizes");
    api.source_spread(2, 0.5);
    check(close(api.haloRadius({ algorithm: 0, spread: 0.5 }, 300), 20 + 6 + 0.5 * 0.06 * 300), "halo starts outside a 40 px knob");
    api.speaker_size(14); api.source_size(16);
    api.source_size(1000);
    check(close(api.haloRadius({ algorithm: 0, spread: 1 }, 300), 30 + 6 + 0.06 * 300), "source_size clamps at 60 px");
    api.source_size(16);
    // speaker colour scale
    check(api.levelOf(1) === 1 && close(api.levelOf(0.5), 1 - 3.0103 / 24, 1e-4) && api.levelOf(0) === 0
          && api.levelOf(Math.pow(10, -3)) === 0, "levelOf: 0 dB = 1, -3 dB ~ 0.87, -30 dB = 0");
    check(calls.includes("show_text") && calls.includes("ellipse"), "paint draws");
    check(calls.includes("arc"), "a VBAP source with spread draws its arch");
    // top-left label: algorithm of the selected source, with the spread focus for VBAP
    api.bypass_ui(0); api.draw_sources(1); api.draw_speakers(1);
    texts.length = 0;
    api.paint();
    check(texts.includes("VBAP  \u00b7  focus 1.6"), "top left: VBAP · focus 1.6 (no source number)");
    api.spread_focus(2.25);
    texts.length = 0;
    api.paint();
    check(texts.includes("VBAP  \u00b7  focus 2.25"), "label follows spread_focus");
    api.spread_focus(1.6);
    api.select_source(3);                // source 3 is DBAP
    texts.length = 0;
    api.paint();
    check(texts.includes("DBAP") && !texts.some(t => /source \d/.test(t) && /VBAP|DBAP/.test(t)), "DBAP source: just DBAP");
    api.select_source(1);
    // arch weights: peak at the source's direction, halving at 180 x spread^1.6, flat at 1
    const sw = api.spreadWeight;
    check(close(sw(0.5, 0), 1, 1e-12) && sw(0.5, 30) < 1 && sw(0.5, 90) < sw(0.5, 30) && sw(0.5, 180) < 0.01, "spread 0.5 arch: peak ahead, falling off");
    const halfAt = 180 * Math.pow(0.5, 1.6), e5 = Math.pow(0.5, 8);
    check(close(sw(0.5, halfAt), 0.5 * (1 - e5) + e5, 1e-9), "spread 0.5 arch: half weight at 180 x 0.5^1.6 = " + halfAt.toFixed(0) + " deg");
    check([0, 60, 120, 180].every(a => close(sw(1, a), 1, 1e-12)), "spread 1 arch: an even ring");
    check(sw(0, 0) === 1 && sw(0, 10) === 0, "spread 0: just the source's direction");
    // selection: default source 1, click selects, select_source, shrinking clamps
    api.bypass_ui(0); api.draw_sources(1); api.edit_speakers(0);
    check(api.sel() === 0, "source 1 selected by default");
    api.paint();                                   // sets the view: field 264 px at offset 18
    api.source(2, 90, 0.3);                        // stereo source 2 centre at x 0.8
    api.select_source(3);
    check(api.sel() === 2, "select_source 3");
    // click on source 1 (az 0, r 0.3 -> x 0.5, y 0.2)
    api.onclick(18 + 0.5 * 264, 18 + 0.2 * 264, 1, 0, 0, 0, 0, 0);
    check(/spread 0\.25/.test(api.readout()), "readout while dragging shows spread: " + api.readout());
    check(!/VBAP|DBAP/.test(api.readout()), "readout has no algorithm");
    check(api.readoutRight() === "distance attenuation 0.0 dB", "bottom right: distance attenuation 0.0 dB");
    api.distance_attenuation(-6);
    check(api.readoutRight() === "distance attenuation -2.4 dB", "bottom right follows distance: " + api.readoutRight());
    api.distance_attenuation(0);
    api.ondrag(18 + 0.5 * 264, 18 + 0.2 * 264, 0);
    check(api.sel() === 0, "clicking a source selects it");
    // a click reports the source only with output_source_position 1
    check(!clicks.some(m => m[1] === "source"), "click without output_source_position: no output");
    api.output_source_position(1);
    clicks.length = 0;
    api.onclick(18 + 0.5 * 264, 18 + 0.2 * 264, 1, 0, 0, 0, 0, 0);   // click, no drag
    const names = clicks.map(m => m[1]).join(" ");
    check(names === "source source_spread source_attenuation", "mono click -> source, source_spread, source_attenuation (no stereo width): " + names);
    check(clicks[0][2] === 1 && close(clicks[0][3], 0) && close(clicks[0][4], 0.6), "position: source 1 0 0.6");
    check(close(clicks[1][3], 0.25), "spread: source_spread 1 0.25");
    check(clicks[2][3] === 0, "attenuation 0 dB with distance_attenuation 0");
    api.distance_attenuation(-6);
    clicks.length = 0;
    api.onclick(18 + 0.5 * 264, 18 + 0.2 * 264, 1, 0, 0, 0, 0, 0);
    check(close(clicks[2][3], -2.4), "attenuation follows distance_attenuation (distance 0.6): " + clicks[2][3]);
    api.ondrag(18 + 0.5 * 264, 18 + 0.2 * 264, 0);
    api.distance_attenuation(0);
    // DBAP source also reports its blur
    api.algorithm(1, 1);
    api.paint();
    clicks.length = 0;
    api.onclick(18 + 0.5 * 264, 18 + 0.2 * 264, 1, 0, 0, 0, 0, 0);
    check(clicks.map(m => m[1]).join(" ") === "source source_spread source_blur source_attenuation", "DBAP click adds source_blur");
    api.ondrag(18 + 0.5 * 264, 18 + 0.2 * 264, 0);
    api.algorithm(1, 0);
    // a stereo source also reports its maximum stereo width (its own, or the global one)
    api.sources_mode(1, 1, 0);
    api.stereo_width(75);
    api.paint();
    const L1 = api.srcs()[0].ch[0];
    clicks.length = 0;
    api.onclick(18 + L1.x * 264, 18 + L1.y * 264, 1, 0, 0, 0, 0, 0);
    check(clicks.map(m => m[1]).join(" ") === "source source_spread source_stereo_width source_attenuation",
          "stereo click adds source_stereo_width: " + clicks.map(m => m[1]).join(" "));
    check(clicks[2][2] === 1 && clicks[2][3] === 75, "source_stereo_width 1 75 (follows the global maximum)");
    api.ondrag(0, 0, 0);
    api.source_stereo_width(1, 40);
    api.paint();
    const L1b = api.srcs()[0].ch[0];
    clicks.length = 0;
    api.onclick(18 + L1b.x * 264, 18 + L1b.y * 264, 1, 0, 0, 0, 0, 0);
    check(clicks[2][3] === 40, "source_stereo_width 1 40 (its own maximum)");
    api.ondrag(0, 0, 0);
    api.sources_mode(0, 1, 0);
    api.stereo_width(60);
    // speaker click in edit mode
    api.edit_speakers(1);
    api.paint();
    clicks.length = 0;
    api.onclick(18 + (0.5 + 0.5 * Math.sin(45 * RAD)) * 264, 18 + (0.5 - 0.5 * Math.cos(45 * RAD)) * 264, 1, 0, 0, 0, 0, 0);
    check(clicks.length === 1 && clicks[0][1] === "speaker" && clicks[0][2] === 2 && close(clicks[0][3], 45) && close(clicks[0][4], 1),
          "speaker click (edit_speakers 1) -> speaker 2 45 1");
    api.ondrag(0, 0, 0);
    api.edit_speakers(0);
    api.ondrag(18 + 0.5 * 264, 18 + 0.2 * 264, 0);
    clicks.length = 0;
    api.onclick(5, 5, 1, 0, 0, 0, 0, 0);                            // empty space
    check(clicks.length === 0, "click on empty space: no output");
    api.output_source_position(0);
    api.num_sources(1);
    api.select_source(1);
    api.num_sources(3);
    api.select_source(3);
    api.num_sources(2);
    check(api.sel() === 1, "num_sources below the selection clamps it");
    check(api.fmtDb(1) === "0.0" && api.fmtDb(0.5) === "-6.0" && api.fmtDb(0) === "-inf", "dB formatting");
    // dragging the L knob of a stereo source: the grabbed knob follows the mouse exactly
    for (const [dist, maxW] of [[1, 60], [0.5, 90], [0.8, 150]]) {
        api.num_sources(2);
        api.sources_mode(0, 1);
        api.source(2, 40, dist);
        api.source_stereo_width(2, maxW);
        api.paint();
        const L = api.srcs()[1].ch[0];
        const px = 18 + L.x * 264, py = 18 + L.y * 264;
        // drag 14 px towards the centre (dragging past the perimeter would be clamped)
        const len = Math.hypot(0.5 - L.x, 0.5 - L.y) * 264;
        const dx = (0.5 - L.x) * 264 / len * 14, dy = (0.5 - L.y) * 264 / len * 14;
        api.onclick(px, py, 1, 0, 0, 0, 0, 0);
        api.ondrag(px + dx, py + dy, 1);
        api.paint();
        const L2 = api.srcs()[1].ch[0];
        const want = [L.x + dx / 264, L.y + dy / 264];
        check(close(L2.x, want[0], 1e-9) && close(L2.y, want[1], 1e-9),
              `drag L knob (distance ${dist}, max width ${maxW}): knob lands under the mouse`);
        api.ondrag(px + dx, py + dy, 0);
    }
}


section("distance_attenuation (global + per source)");
{
    const api = load();
    api.speaker_coords(...[0, 45, 90, 135, 180, 225, 270, 315]);
    api.num_sources(3);
    api.sources_mode(0, 1, 0);
    const pw = (k, j = 0) => power(Array.from(api.state().gains[k][j]));
    const dB = v => 10 * Math.log10(v);
    for (const k of [1, 2, 3]) api.source(k, 30, 0);
    check(api.state().gains.every(c => c.every(g => close(power(Array.from(g)), 1))), "default 0: unchanged");
    api.distance_attenuation(-6);
    check(close(dB(pw(0)), -6, 1e-9) && close(dB(pw(2)), -6, 1e-9), "global -6: sources at the centre are -6 dB");
    check(close(dB(pw(1, 0)), -6, 1e-9) && close(dB(pw(1, 1)), -6, 1e-9), "stereo: both channels -6 dB");
    api.source(1, 30, 0.5);                              // halfway to the ring (the perimeter)
    check(close(dB(pw(0)), -3, 1e-9), "halfway: -3 dB (linear in dB)");
    api.source(1, 30, 1);
    check(close(dB(pw(0)), 0, 1e-9), "on the ring (perimeter): 0 dB");
    for (let i = 1; i <= 8; i++) api.speaker_distance(i, 0.8);   // pull the speakers in
    check(close(dB(pw(0)), 0, 1e-9), "outside the (pulled-in) ring: 0 dB");
    api.source(1, 30, 0.4);
    check(close(dB(pw(0)), -3, 1e-9), "halfway to a ring at 0.8: -3 dB");
    for (let i = 1; i <= 8; i++) api.speaker_distance(i, 1);
    // on a speaker at the ring: that speaker at exactly 0 dB
    api.source(1, 45, 1);
    check(close(api.state().gains[0][0][1], 1, 1e-12), "source on a speaker -> 0 dB on it");
    // per-source override survives global changes
    api.source(1, 0, 0);
    api.source_distance_attenuation(1, -12);
    check(close(dB(pw(0)), -12, 1e-9) && close(dB(pw(2)), -6, 1e-9), "source 1 override -12, source 3 global -6");
    api.distance_attenuation(-3);
    check(close(dB(pw(0)), -3, 1e-9) && close(dB(pw(2)), -3, 1e-9), "distance_attenuation -3 resets every source (last one wins)");
    api.source_distance_attenuation(1, -12);
    check(close(dB(pw(0)), -12, 1e-9) && close(dB(pw(2)), -3, 1e-9), "then source 1 -12 overrides again");
    api.source_distance_attenuation(1);
    check(close(dB(pw(0)), -3, 1e-9), "no value -> back to global");
    // DBAP too
    api.algorithm(3, 1);
    check(close(dB(pw(2)), -3, 1e-9), "applies to DBAP sources");
    // continuity across the ring
    api.algorithm(3, 0);
    let prev = null, jump = 0;
    for (let r = 0; r <= 1; r += 0.002) { api.source(3, 10, r); const v = dB(pw(2)); if (prev !== null) jump = Math.max(jump, Math.abs(v - prev)); prev = v; }
    check(jump < 0.05, "level is continuous from the centre to the perimeter (max step " + jump.toFixed(4) + " dB)");
    // state + dump
    api.source_distance_attenuation(2, -9);
    const v = api.getvalueof();
    const b = load();
    b.distance_attenuation(-3);            // global first, as embedded messages restore it
    b.setvalueof(...v);
    check(JSON.stringify(b.getvalueof()) === JSON.stringify(v), "override saved in state");
    api.out.length = 0;
    api.dump();
    check(api.out.some(m => m[1] === "distance_attenuation" && m[2] === -3)
          && api.out.some(m => m[1] === "source_distance_attenuation" && m[2] === 2 && m[3] === -9), "dump reports global and override");
}


section("Speakers in azimuths: speaker_coords, speaker, get_speakers");
{
    const api = load();
    api.speaker_coords(-30, 30, 110, -110);
    api.num_sources(1);
    api.speaker(2, 90);                  // default distance: the perimeter (1)
    let o = api.state().spk[1];
    check(close(o.x, 1) && close(o.y, 0.5), "speaker 2 90 -> on the perimeter at 90 deg");
    api.speaker(3, 180, 0.4);
    o = api.state().spk[2];
    check(close(o.x, 0.5) && close(o.y, 0.7), "speaker 3 180 0.4 -> behind, closer");
    api.speaker_azimuth(3, 0);
    o = api.state().spk[2];
    check(close(o.x, 0.5) && close(o.y, 0.3), "speaker_azimuth keeps the distance");
    api.speaker_distance(3, 0.8);
    o = api.state().spk[2];
    check(close(o.x, 0.5) && close(o.y, 0.1), "speaker_distance keeps the azimuth");
    api.out.length = 0;
    api.get_speakers();
    check(api.out.length === 1 && api.out[0][1] === "speaker_coords", "get_speakers -> one speaker_coords message");
    const m = api.out[0];
    check(close(m[2], -30) && close(m[3], 90) && close(m[4], 0) && close(m[5], -110),
          "speaker_coords -30 90 0 -110, in list order: " + m.slice(2).map(v => v.toFixed(1)));
    // what get_speakers outputs is a valid layout message for this object too
    const b = load();
    b.num_sources(1);
    b.speaker_coords(...m.slice(2));
    check(b.state().spk.length === 4 && close(b.state().spk[1].x, 1), "speaker_coords round-trips");
    api.out.length = 0;
    api.dump();
    const sp = api.out.find(x => x[1] === "speaker" && x[2] === 3);
    check(sp && close(sp[3], 0) && close(sp[4], 0.8), "dump reports speaker <i> <az> <dist> (0..1)");
}


section("spread_focus");
{
    const api = load();
    api.num_sources(2);
    api.vbap_center_blend(0);
    const g = k => Array.from(api.state().gains[k][0]);
    const bell = (sp, f, L, a) => {
        const h = 180 * Math.pow(sp, f);
        const p = h >= 180 - 1e-9 ? 0 : Math.log(0.5) / Math.log((1 + Math.cos(h * RAD)) / 2);
        const acc = new Array(L.length).fill(0);
        for (let k = -180; k < 180; k += 0.05) {
            const w = Math.pow((1 + Math.cos(k * RAD)) / 2, p);
            if (w < 1e-9) continue;
            refVBAP(L, a + k).forEach((v, j) => { acc[j] += v * w; });
        }
        const n = Math.hypot(...acc), e = Math.pow(sp, 8);
        return acc.map(v => Math.sqrt((1 - e) * (v / n) ** 2 + e / L.length));
    };
    let worst = 0;
    for (const L of [[0, 45, 90, 135, 180, 225, 270, 315], [-30, 30, 0, 110, -110]]) {
        api.speaker_coords(...L);
        for (const f of [0.5, 1, 3, 6]) {
            api.spread_focus(f);
            for (const sp of [0.3, 0.6, 0.85]) {
                api.source_spread(1, sp);
                for (const a of [0, 20, 100]) {
                    api.source(1, a, 1);
                    worst = Math.max(worst, ...g(0).map((v, j) => Math.abs(v - bell(sp, f, L, a)[j])));
                }
            }
        }
    }
    check(worst < 2e-3, "spread_focus 0.5..6: engine = independent bell reference (worst " + worst.toExponential(2) + ")");
    // higher focus = more pointed at mid spread; the ends do not change
    api.speaker_coords(0, 45, 90, 135, 180, 225, 270, 315);
    api.source(1, 0, 1);
    api.source_spread(1, 0.5);
    const drop = f => { api.spread_focus(f); const v = g(0); return 20 * Math.log10(v[0] / v[1]); };
    check(drop(0.75) < drop(1.6) && drop(1.6) < drop(3), "focus 0.75 < 1.6 < 3: neighbours drop more with focus");
    check(close(drop(1.6), 3, 0.05), "default focus 1.6: 3 dB at spread 0.5");
    for (const f of [0.5, 4]) {
        api.spread_focus(f);
        api.source_spread(1, 1);
        check(g(0).every(v => close(v, Math.sqrt(1 / 8), 1e-12)), "focus " + f + ": spread 1 still all equal");
        api.source_spread(1, 0);
        check(close(g(0)[0], 1, 1e-12), "focus " + f + ": spread 0 still a point");
    }
    // global: applies to every source
    api.source_spread(0.5);
    api.source(2, 0, 1);
    api.spread_focus(4);
    check(close(g(0)[0], g(1)[0], 1e-12), "spread_focus applies to all sources alike");
    api.spread_focus(1.6);
}


section("Gain invariants across every feature (randomized)");
{
    const api = load();
    const layouts = [[0, 45, 90, 135, 180, 225, 270, 315], [-30, 30, 0, 110, -110], [-30, 30], [-90, 90], [-45, 45, 135, -135], [0],
                     [-45, 45, -135, 135, 0, -90, 90, 180], [-30, 30, -150, 150, 0, -90, 90, 180]];
    let bad = 0, maxGain = 0, powErr = 0, lists = 0;
    for (let t = 0; t < 6000; t++) {
        const L = layouts[t % layouts.length];
        api.speaker_coords(...L);
        if (rnd() < 0.3) for (let i = 1; i <= L.length; i++) api.speaker(i, L[i - 1] + (rnd() - 0.5) * 20, 0.5 + 0.5 * rnd());
        if (rnd() < 0.3) for (let i = 1; i <= L.length; i++) api.speaker_weight(i, rnd() < 0.2 ? 0 : rnd() * 2);
        api.num_sources(3);
        api.sources_mode(rnd() < 0.5 ? 1 : 0, rnd() < 0.5 ? 1 : 0, 0);
        api.vbap_center_blend(rnd() < 0.8 ? 1 : 0);
        api.dbap_hull(rnd() < 0.5 ? 1 : 0);
        api.dbap_rolloff_(1 + rnd() * 10);
        api.spread_focus(0.25 + rnd() * 7.75);
        api.stereo_width(rnd() * 180);
        api.distance_attenuation(rnd() < 0.5 ? 0 : -rnd() * 24);
        for (let k = 1; k <= 3; k++) {
            api.algorithm(k, rnd() < 0.3 ? 1 : 0);
            // include tiny spreads: with a high focus they once produced NaN
            api.source_spread(k, rnd() < 0.2 ? 0 : rnd() < 0.2 ? 1 : rnd() < 0.2 ? rnd() * 0.02 : rnd());
            api.source_blur(k, rnd() * 3);
            api.source(k, rnd() * 360 - 180, rnd() < 0.1 ? 0 : rnd() < 0.1 ? 1 : rnd());
            if (rnd() < 0.2) api.source_stereo_width(k, rnd() * 180);
            if (rnd() < 0.2) api.source_distance_attenuation(k, -rnd() * 20);
        }
        if (rnd() < 0.2) api.mirror_sources(1, 2, ["lr", "fb", "point"][t % 3]);
        const st = api.state();
        st.gains.forEach((chs, k) => chs.forEach(gc => {
            lists++;
            const v = Array.from(gc);
            if (v.some(x => !Number.isFinite(x) || x < -1e-12)) bad++;
            maxGain = Math.max(maxGain, ...v.filter(Number.isFinite));
            const a = api.attenuation(st.src[k]);
            const pw = v.reduce((q, x) => q + x * x, 0);
            if (pw > 0) powErr = Math.max(powErr, Math.abs(pw - a * a));
        }));
    }
    check(bad === 0, "no NaN / negative gains in " + lists + " gain lists (got " + bad + ")");
    check(maxGain <= 1 + 1e-12, "no gain above 1 (0 dB): max " + maxGain);
    check(powErr < 1e-12, "sum of g^2 = attenuation^2 for every list (worst error " + powErr.toExponential(2) + ")");
    // the case that broke: tiny spread + high focus
    api.speaker_coords(-45, 45, 135, -135);
    api.num_sources(1);
    api.spread_focus(8);
    api.source(1, 20, 1);
    for (const sp of [1e-9, 1e-4, 0.003, 0.02]) {
        api.source_spread(1, sp);
        const v = Array.from(api.state().gains[0][0]);
        check(v.every(Number.isFinite) && close(v.reduce((q, x) => q + x * x, 0), 1, 1e-12), "spread " + sp + " with focus 8: valid, unit power");
    }
    api.distance_attenuation(12);
    check(api.attenuation(api.state().src[0]) === 1, "positive distance_attenuation is clamped to 0 dB (never boosts)");
    api.spread_focus(1.6);
}

section("State round-trip");
{
    const a = load();
    a.speaker_coords(-30, 30, 110, -110);
    a.num_sources(3);
    a.algorithm(2, 1);
    a.source_blur(2, 0.4);
    a.source_spread(1, 60 / 360);
    a.speaker_weight(3, 0.5);
    a.source_xy(3, 0.1, 0.9);
    a.sources_mode(0, 1, 0);
    a.stereo_width(45);
    a.source_stereo_width(2, 80);          // after the global one (which would reset it)
    a.mirror_sources(1, 3, "fb");
    const v = a.getvalueof();
    const b = load();
    b.setvalueof(...v);
    check(JSON.stringify(b.getvalueof()) === JSON.stringify(v), "getvalueof/setvalueof round-trip");
    for (let k = 0; k < 3; k++) {
        const ga = a.state().gains[k], gb = b.state().gains[k];
        check(ga.length === gb.length && ga.every((c, j) => vecClose(Array.from(c), Array.from(gb[j]), 1e-12)), "restored gains match, source " + (k + 1));
    }
    // dump messages are valid inputs
    a.out.length = 0;
    a.dump();
    const names = new Set(a.out.map(m => m[1]));
    for (const nm of names) check(typeof a[nm] === "function" || nm === "speaker" || nm === "source", "dump emits unknown message " + nm);
}

console.log(`\n${checks} checks, ${failures} failures`);
process.exit(failures ? 1 : 0);
