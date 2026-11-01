// =============================================================================
// Kia Sorento Key Case - 2-Part Clamshell Split for ASA 3D Printing
// =============================================================================
// Material: ASA (Rigid filament, low flex, ~0.5% shrinkage)
// Purpose:  Splits the digital key fob case at the parting line (Z = 0)
//           into Upper and Lower shells so the rigid key fob can be inserted
//           easily and the two halves join securely, yet open by hand.
//
// The side windows (Z -4.2 .. +4.2) leave only four wall posts crossing Z = 0,
// 0.7 - 1.6 mm thick; no wall is thicker than ~2 mm. joint_style selects:
//
// press_fit Half-lap with crush ribs (friction; proved too loose).
//           - Within a belt around the parting line every post is thickened
//             OUTWARD to at least min_wall.
//           - Lower half: the inner tongue_w of the wall rises tongue_h above
//             Z = 0 as a tongue, with a lead-in chamfer and vertical crush ribs
//             on its outer face.
//           - Upper half: matching slot (tongue_w + clearance wide, slightly
//             deeper than the tongue) so the halves seat on the outer shoulder.
//           - Pry notch in the lower half's outer shoulder for opening.
// snap      Four cantilever arms hang from the upper rim on the wall posts
//           (the side windows are left clear for the fob's buttons); each hook
//           clicks into a notch in the lower rim. The wall is thickened
//           outward around each latch (both halves) so the arm runs in a
//           pocket that stays closed to the outside. The halves pull apart by
//           hand (hook_return_angle < 90).
// hinge     Pin hinge at the top-arc apex (pin = 1.75 mm filament offcut) and
//           two snap latches on the posts near the open end.
// magnet    Four external lugs at the seam, each holding a 5 x 2 mm magnet
//           pair (glued, flush with the seam face), plus the press-fit tongue
//           without ribs as a shear locator.
//
// KIA logo: the base model engraves it 0.2 mm deep in the lower half's outer
//           face; it is cut kia_depth deep, and colour_part = "kia" gives the
//           flush inlay that fills it, for a second colour.
// Logo:     B3D_Labs.svg, small, cut logo_depth into the upper half's outer
//           face directly behind the KIA logo; on the upper half,
//           colour_part = "kia" gives its inlay, so both logos share a colour.
//
// Printing: Print both halves outer face down (flip the upper half 180 deg in
//           the slicer). Print part = "coupon" first; it tests the selected
//           joint_style.
// =============================================================================

/* [Render Options] */
// Select which component to display or export
part = "assembly"; // ["assembly", "exploded", "upper", "lower", "coupon"]

// Select joint mechanism
joint_style = "snap"; // ["press_fit", "snap", "hinge", "magnet", "flat"]

// Two-colour logos: the half ("all" and "body" are the same), or the flush
// inlay that fills its logo (KIA on the lower half, B3D Labs on the upper)
colour_part = "all"; // ["all", "body", "kia"]

/* [Joint Parameters] */
// Minimum wall thickness at the joint; thinner posts are thickened outward (mm)
min_wall = 1.7;

// Width of the tongue, measured from the inner (cavity) face (mm)
tongue_w = 0.8;

// Height of the tongue above the parting plane (mm)
tongue_h = 2.0;

// Side gap between tongue face and slot wall (mm)
// Choose with the test coupon: 0.05 / 0.10 / 0.15
clearance = 0.10;

// Extra slot depth so the halves seat on the outer shoulder, not the tongue tip (mm)
slot_extra_depth = 0.2;

// 45 deg lead-in chamfer on the tongue's outer top edge (mm)
lead_in = 0.4;

// 45 deg chamfer on the slot mouth (mm)
slot_chamfer = 0.3;

// Crush rib protrusion from the tongue face; interference = rib_height - clearance (mm)
rib_height = 0.30;

// Crush rib footprint radius (rib width ~ 2 x rib_r) (mm)
rib_r = 0.45;

/* [Thickening Belt] */
// Half-height of the full-thickness belt around Z = 0 (mm)
belt_half = 3.0;

// How far past a post the thickening may reach; also the 45 deg taper length (mm)
belt_reach = 1.05;

/* [Pry Notch] */
// X centre of the notch on the top arc (mm)
notch_x = 21;
notch_w = 3.0;
notch_h = 1.0;
notch_d = 0.8;

/* [Logo] */
// Inlay the B3D Labs logo into the upper half's outer face
logo = true;
logo_file = "B3D_Labs.svg";
// Logo height along Y; width follows the SVG aspect ratio. Its strokes and
// gaps are ~4.8 % of it, so 9 mm keeps them ~0.43 mm, one nozzle line (mm)
logo_height = 9;
// Logo centre: at the KIA logo's height (centre of its Y 5.02-9.95), and
// like it near the left post: seen from outside, its left edge lines up
// with the KIA's outer end (X 3.92) on the lower face; 7.68 mm wide (mm)
logo_center = [7.76, 7.49];
// Cut depth: 3 layers, the same as kia_depth (mm)
logo_depth = 0.6;

/* [KIA Logo] */
// The base model engraves the KIA logo 0.2 mm deep in the lower face; it is
// cut this deep instead, and the "kia" part fills it flush (mm)
kia_depth = 0.6;

/* [Snap Latches] */
// Arm width along the wall (mm)
latch_w = 5;
// Arm thickness, measured outward from arm_gap off the fob cavity. 1.2 was
// too weak to click; 1.6 is ~2.4x stiffer and still flexes 1 mm at ~1.4 %
// strain across the layer lines (mm)
arm_t = 1.6;
// Gap between the arm's inner face and the fob cavity (mm)
arm_gap = 0.1;
// Z of the arm tip; the hook sits just above it. The notch is cut into the
// lower floor under the cavity's rounded edge (which starts at |Z| ~5.7);
// at -7.6 the lip over the hook was only 0.2-0.6 mm thick, now ~0.8-1 (mm)
arm_bottom = -8.45;
// Z where the arm's outer face starts its 45 deg chamfer into the upper rim (mm)
arm_root_z = 6;
// Hook protrusion into the lower rim; the lead-in is 45 deg (mm)
hook_d = 1.0;
// Flat land between the lead-in and the retaining face (mm)
hook_land = 0.2;
// Retaining face: 45-60 = pulls apart by hand. The pockets are closed to the
// outside, so 90 (positive lock) could only be opened by breaking an arm (deg)
hook_return_angle = 60;
// Side clearance between arm and pocket (mm)
latch_clearance = 0.15;
// Vertical play between hook and notch. Negative = preload: the hook rests
// on the notch's retaining face with the arm still sprung (0.1 mm here holds
// it ~0.17 mm out), so the arm pulls the seam shut, and layer rounding or
// overhang sag up to ~0.4 mm is taken up on the face instead of leaving a
// gap. A positive play smaller than a layer jammed the hooks (mm)
latch_z_play = -0.1;
// Room outward of the arm for it to flex over the hook (mm)
arm_flex = hook_d + 0.1;
// Outer skin left over the pocket; the wall is thickened outward to fit it (mm)
latch_skin = 0.8;
// Pad wall beside the pocket at each end (mm)
latch_side = 1.0;
// The arm is free of the upper wall up to this Z: 1.2 mm past the side
// windows' top (4.2), just short of the cavity's rounded edge, for a longer,
// lower-strain arm. The pad closes the slot to the outside (mm)
arm_free_z = 5.4;
// Fingernail slot beside the coupon arm, for levering it out; 0 = none (mm)
nail_w = 1.2;

/* [Hinge] */
// Top-arc apex Y, read from the STL (mm)
apex_y = 78.82;
knuckle_r = 2.5;
// X of the first knuckle; knuckles alternate lower, upper, lower (mm)
knuckle_x0 = 16;
knuckle_len = 3;
knuckle_gap = 0.4;
// How far the knuckles sink into the apex (mm)
knuckle_overlap = 0.5;
// Radial clearance around the other half's knuckles (mm)
knuckle_clearance = 0.3;
// Pin hole for a 1.75 mm filament pin (teardrop, mm)
pin_d = 1.85;
// Extra pocket width on the open-end side of the hinge latches; their arms swing in on an arc (mm)
hinge_latch_swing = 0.4;

/* [Magnets] */
mag_d = 5;
mag_h = 2;
// Pocket diameter = mag_d + mag_clear; choose with the test coupon (mm)
mag_clear = 0.2;
// Pocket depth beyond mag_h, for the glue (mm)
mag_depth_extra = 0.05;
// Lug radius around the magnet (mm)
lug_r = 3.4;
// Lug width where it joins the wall (mm)
lug_root_w = 9;
// Straight lug height from the seam before the 45 deg taper (mm)
lug_flat = 2.5;
// Side clearance of the locator tongue in magnet mode (mm)
mag_tongue_clearance = 0.15;

/* [Test Coupon] */
coupon_clearances = [0.05, 0.10, 0.15];
coupon_len = 20;
coupon_wall_h = 4;
coupon_floor_w = 6;
coupon_floor_t = 1.2;
// snap coupon: one pair per retaining-face angle
coupon_hook_angles = [90, 60, 45];
// snap coupon: wall thickness between outer face and the "cavity" (mm)
coupon_latch_wall = 1.0;
// hinge coupon: one pair per pin hole diameter
coupon_pin_ds = [1.80, 1.85, 1.90];
// magnet coupon: one pocket per clearance (pocket = mag_d + clearance)
coupon_mag_clears = [0.10, 0.20, 0.30];

/* [Display] */
// Exploded view separation distance (mm)
exploded_offset = 15;

$fn = 60;

// Crush rib centres on the tongue's outer face, ~7 mm apart and >= 1.5 mm from
// post ends. Generated from the STL (cavity offset by tongue_w, clipped to the
// thickened posts); regenerate if tongue_w, min_wall or the base model change.
rib_points = [
    [-0.96, 1.5], [-0.96, 8.5], [-0.96, 15.5],                          // left post
    [-0.96, 49.7], [0.15, 57.0], [3.99, 63.37], [8.73, 69.12],          // top arc
    [14.05, 74.31], [20.65, 77.51], [27.66, 75.42],
    [43.74, 29.13], [43.35, 21.33], [42.44, 13.59], [38.64, 6.84],      // right lower post
    [33.41, 1.05],
    [40.35, 64.36], [43.17, 58.33]                                       // right upper post
];

// Snap latches as [x, y, outward normal angle] or [x, y, angle, arm width]: a
// point on the cavity line and its wall normal. The side windows hold the
// fob's buttons, so every latch, pad included, sits on a wall post (Z = 0
// slice: left post Y 0-16.3, right lower post Y 0-30, top-arc post from Y 48.9
// on the left round to X 28, right upper post Y 57.4-64.6). Read from the
// STL; regenerate if the base model changes.
snap_latches = [
    [-0.16,  8.00, 180],        // A: left post
    [42.61, 22.15,  -4],        // B: right lower post, straight run
    [10.18, 69.54, 138],        // C: top-arc post, top-left diagonal
    [41.58, 60.97,  23, 4]      // D: right upper post, too short for latch_w
];
// On Y-aligned posts only: the swing pocket widens towards -Y
hinge_latches = [
    [-0.16,  8.00, 180],        // left post
    [42.54, 21.16,  -4]         // right lower post, straight run
];

// Magnet lugs as [x, y, outward normal angle]: magnet centres 0.5 mm + pocket
// radius off the cavity along the wall normal, on straight runs of the posts.
// Generated from the STL; regenerate if mag_d, mag_clear or the base model change.
mag_lugs = [
    [-3.23,  8.00, 180],    // left post
    [-3.13, 53.33, 174],    // left side of the top-arc post
    [45.78, 23.85,  -3],    // right lower post
    [45.06, 60.30,  15]     // right upper post
];

// Z at which the side windows are closed, used to read the cavity outline
ring_probe_z = 5;

// Z of the flat outer faces (top = +face_z, bottom = -face_z), read from the STL
face_z = 10.302;

// Box round the KIA logo engraved in the lower face (X 3.92-23.99,
// Y 5.02-9.95), read from the STL
kia_box = [[3.5, 4.5], [24.5, 10.5]];

// Set true inside the coupons: latch strips use a straight wall along X
$coupon = false;

// -----------------------------------------------------------------------------
// Base 3D Model
// -----------------------------------------------------------------------------
module base_model() {
    import("from_openscad.stl", convexity=10);
}

// 2D slice profile at the Z = 0 parting plane (the four wall posts)
module parting_slice_2d() {
    projection(cut = true)
        base_model();
}

// Closed wall ring above the side windows
module ring_2d() {
    projection(cut = true)
        translate([0, 0, -ring_probe_z])
            base_model();
}

// Outer outline (convex)
module outer_2d() {
    hull() ring_2d();
}

// Fob cavity; matches the posts' inner faces at Z = 0 (the ring is still open
// at the open end here, which only adds the end slot to the cavity). The
// rounded opening removes slivers left between the ring and its hull; a delta
// offset would turn those slivers into long miter spikes.
module cavity_2d() {
    offset(r = 0.3) offset(r = -0.3)
        difference() {
            outer_2d();
            ring_2d();
        }
}

// Band of width w measured outward from the cavity
module inner_band_2d(w) {
    difference() {
        offset(delta = w) cavity_2d();
        cavity_2d();
    }
}

// Wall band reaching min_wall around each post (clipped at the open end, Y = 0).
// It overlaps the posts on purpose so the union leaves no hairline voids.
module belt_add_2d() {
    intersection() {
        inner_band_2d(min_wall);
        offset(r = belt_reach) parting_slice_2d();
        translate([-50, 0]) square([200, 200]);
    }
}

// Thickened wall at the parting plane
module wall_2d() {
    union() {
        parting_slice_2d();
        belt_add_2d();
    }
}

// Tongue footprint, optionally narrowed from its outer side by inset
module tongue_2d(inset = 0) {
    intersection() {
        wall_2d();
        inner_band_2d(tongue_w - inset);
    }
}

// Crush ribs: circles on the tongue face, clipped to a band rib_height wide
module ribs_2d(inset = 0) {
    intersection() {
        difference() {
            offset(delta = tongue_w + rib_height - inset) cavity_2d();
            offset(delta = tongue_w) cavity_2d();
        }
        wall_2d();
        for (p = rib_points) translate(p) circle(r = rib_r);
    }
}

// -----------------------------------------------------------------------------
// Generic helpers
// -----------------------------------------------------------------------------
// Extrude children from z0 for height h; the last `chamfer` mm is stepped in
// layer-sized slices with $inset growing to `chamfer` (45 deg taper).
module taper_top(z0, h, chamfer, steps = 4) {
    translate([0, 0, z0])
        linear_extrude(height = h - chamfer + 0.001)
            let($inset = 0) children();
    for (i = [1 : steps])
        translate([0, 0, z0 + h - chamfer + (i - 1) * chamfer / steps])
            linear_extrude(height = chamfer / steps + 0.001)
                let($inset = i * chamfer / steps) children();
}

// Same, but the taper is at the bottom ($inset shrinks from `chamfer` to 0)
module taper_bottom(z0, h, chamfer, steps = 4) {
    for (i = [0 : steps - 1])
        translate([0, 0, z0 + i * chamfer / steps])
            linear_extrude(height = chamfer / steps + 0.001)
                let($inset = (steps - i) * chamfer / steps) children();
    translate([0, 0, z0 + chamfer])
        linear_extrude(height = h - chamfer)
            let($inset = 0) children();
}

// Extrude children from z0 for height h in `steps` slices, $inset going
// linearly from i0 to i1 (sampled mid-slice). Any taper angle.
module ramp(z0, h, i0, i1, steps = 4) {
    if (h > 0)
        for (i = [0 : steps - 1])
            translate([0, 0, z0 + i * h / steps])
                linear_extrude(height = h / steps + 0.001)
                    let($inset = i0 + (i1 - i0) * (i + 0.5) / steps) children();
}

module below_parting() {
    translate([-50, -50, -50]) cube([150, 200, 50]);
}

module above_parting() {
    translate([-50, -50, 0]) cube([150, 200, 50]);
}

// -----------------------------------------------------------------------------
// Joint features (case)
// -----------------------------------------------------------------------------
// Outward thickening belt, full thickness for |Z| <= belt_half, then a 45 deg
// taper back to the original surface over belt_reach.
module belt() {
    H = belt_half + belt_reach;
    intersection() {
        translate([0, 0, -H])
            linear_extrude(height = 2 * H) belt_add_2d();
        hull() {
            translate([0, 0, -H])
                linear_extrude(height = 2 * H) outer_2d();
            translate([0, 0, -belt_half])
                linear_extrude(height = 2 * belt_half)
                    offset(delta = belt_reach) outer_2d();
        }
    }
}

module tongue() {
    taper_top(0, tongue_h, lead_in) tongue_2d($inset);
}

module ribs() {
    taper_top(0, tongue_h - lead_in, rib_height) ribs_2d($inset);
}

module slot(c = clearance) {
    translate([0, 0, -0.01])
        taper_bottom(0, tongue_h + slot_extra_depth + 0.01, slot_chamfer)
            offset(delta = tongue_w + c + $inset) cavity_2d();
}

// Pry notch cut into the lower half's outer shoulder on the top arc
module pry_notch() {
    intersection() {
        translate([notch_x - notch_w / 2, 0, -notch_h])
            cube([notch_w, 200, notch_h + 0.01]);
        translate([0, 0, -notch_h - 0.01])
            linear_extrude(height = notch_h + 0.03)
                difference() {
                    offset(delta = 1) outer_2d();
                    offset(delta = -notch_d) outer_2d();
                }
    }
}

// -----------------------------------------------------------------------------
// Snap latches
// -----------------------------------------------------------------------------
// All latch features are strips between two offsets of the fob cavity (a < b,
// outward positive), cut to a box around the latch. In the coupons ($coupon)
// the wall runs along X with its outer face at Y = 0 and the cavity line at
// Y = coupon_latch_wall, and the latch is centred on X = 0.
//
// Z layout (assembled): arm from the upper rim down to arm_bottom, free of the
// upper wall below arm_free_z; hook = 45 deg lead-in, land, retaining face at
// hook_top; lower rim pocket down to arm_bottom - 0.2 with a notch behind the
// hook. On the case the posts are too thin to hold the pocket, so both halves
// get a pad that thickens the wall outward to pad_t; the pocket stops
// latch_skin short of its outer face.

hook_top = arm_bottom + hook_d + hook_land;
pocket_bottom = arm_bottom - 0.2;
// Outer face of the pocket and of the pad, from the cavity line
pocket_outer = arm_gap + arm_t + arm_flex;
pad_t = pocket_outer + latch_skin;
// The pad is full thickness for |Z| <= pad_z (just past the fob cavity), then
// chamfered 45 deg into the top and bottom faces
pad_z = 8.7;

// Height of the retaining face for a given angle (0 = flat, positive lock)
function return_h(ang) = ang >= 90 ? 0 : hook_d / tan(ang);

// Arm width of latch l
function latch_width(l) = len(l) > 3 ? l[3] : latch_w;

// Pocket shift along the wall that widens it by `swing` towards -Y only; the
// wall tangent's Y component is cos(angle)
function swing_shift(l, swing) = -swing / 2 * ($coupon || cos(l[2]) >= 0 ? 1 : -1);

// Latch l = [x, y, angle(, w)]. Its features are built in a local frame
// (origin on the cavity line, +X = outward normal, +Y = counter-clockwise
// along the wall) and placed once in 3D: a box rotated in 2D gets its corners
// snapped differently in every extruded slice and leaves non-manifold slivers.
module latch_frame(l) {
    if ($coupon)
        children();
    else
        translate([l[0], l[1], 0]) rotate([0, 0, l[2]]) children();
}

// Strip in the latch frame, w wide along the wall, moved `shift` along it
module latch_strip_2d(l, a, b, w, shift = 0) {
    intersection() {
        if ($coupon)
            translate([-50, coupon_latch_wall - b]) square([100, b - a]);
        else
            rotate(-l[2]) translate([-l[0], -l[1]])
                difference() {
                    offset(delta = b) cavity_2d();
                    offset(delta = a) cavity_2d();
                }
        if ($coupon)
            translate([shift - w / 2, -20]) square([w, 40]);
        else
            translate([-10, shift - w / 2]) square([20, w]);
    }
}

module hook_2d(l) {
    latch_strip_2d(l, arm_gap - hook_d + $inset, arm_gap + 0.01, latch_width(l));
}

// Arm with hook, added to the upper half
module latch_arm(l, ang = hook_return_angle) latch_frame(l) {
    w = latch_width(l);
    translate([0, 0, arm_bottom])
        linear_extrude(height = arm_root_z - arm_bottom)
            latch_strip_2d(l, arm_gap, arm_gap + arm_t, w);
    // Outer face chamfered 45 deg into the rim
    ramp(arm_root_z, arm_t, 0, arm_t)
        latch_strip_2d(l, arm_gap, arm_gap + arm_t - $inset, w);
    ramp(arm_bottom, hook_d, hook_d, 0) hook_2d(l);
    translate([0, 0, arm_bottom + hook_d])
        linear_extrude(height = hook_land + 0.001) let($inset = 0) hook_2d(l);
    ramp(hook_top, return_h(ang), 0, hook_d) hook_2d(l);
}

// Wall pad around a latch, both halves (clip to the half). It starts 0.2 mm
// inside the wall (posts are >= 0.68 mm thick): a face on the cavity line
// would nearly coincide with the wall's inner face and leave slivers. Beyond
// |Z| = pad_z it reaches 2 mm into the face plates so the chamfer meets the
// rounded edge.
module latch_pad(l, swing = 0) latch_frame(l) {
    w = latch_width(l) + 2 * (latch_clearance + latch_side) + swing;
    s = swing_shift(l, swing);
    translate([0, 0, -pad_z])
        linear_extrude(height = 2 * pad_z)
            latch_strip_2d(l, 0.2, pad_t, w, s);
    for (m = [0, 1]) mirror([0, 0, m])
        ramp(pad_z - 0.001, face_z - pad_z + 0.002, 0, face_z - pad_z, steps = 8)
            latch_strip_2d(l, -2, pad_t - $inset, w, s);
}

// Slot freeing the arm from the upper wall between the seam and arm_free_z
module latch_slot(l) latch_frame(l) {
    translate([0, 0, -0.01])
        linear_extrude(height = arm_free_z + 0.01)
            latch_strip_2d(l, arm_gap - latch_clearance, pocket_outer,
                           latch_width(l) + 2 * latch_clearance);
}

// Pocket and hook notch, cut from the lower half. `swing` widens the pocket
// towards -Y (the open end) for arms that close on a hinge arc. The coupon's
// pocket is open to the outside, with a nail slot for levering the arm out.
module latch_pocket(l, swing = 0, ang = hook_return_angle) latch_frame(l) {
    w = latch_width(l) + 2 * latch_clearance + swing;
    s = swing_shift(l, swing);
    // A flat (90 deg) face can't take preload: give it play instead
    notch_top = hook_top + (ang >= 90 ? max(latch_z_play, 0.1) : latch_z_play);
    translate([0, 0, pocket_bottom])
        linear_extrude(height = -pocket_bottom + 0.01)
            latch_strip_2d(l, arm_gap - latch_clearance, $coupon ? 5 : pocket_outer, w, s);
    translate([0, 0, pocket_bottom])
        linear_extrude(height = notch_top - pocket_bottom)
            latch_strip_2d(l, arm_gap - hook_d - 0.1, arm_gap, w, s);
    ramp(notch_top, return_h(ang), 0, hook_d + 0.1)
        latch_strip_2d(l, arm_gap - hook_d - 0.1 + $inset, arm_gap, w, s);
    if ($coupon && nail_w > 0)
        translate([0, 0, pocket_bottom])
            linear_extrude(height = -pocket_bottom + 0.01)
                latch_strip_2d(l, arm_gap - hook_d - 0.15, 5, nail_w + 0.2,
                               s + (w + nail_w) / 2 - 0.1);
}

// -----------------------------------------------------------------------------
// Hinge
// -----------------------------------------------------------------------------
// Axis along X at Z = 0, just outside the top-arc apex. Knuckles 0 and 2 belong
// to the lower half, knuckle 1 to the upper. Each knuckle's web is a hull down
// to a line inside the wall, tangent to the knuckle at 45 deg, clipped to its
// own half: a web crossing Z = 0 would sweep into the other half on opening.

hinge_axis_y = apex_y + knuckle_r - knuckle_overlap;
hinge_web_y = 75.5;     // inside the top-arc wall over the knuckle span
hinge_len = 3 * knuckle_len + 2 * knuckle_gap;

function knuckle_x(i) = knuckle_x0 + i * (knuckle_len + knuckle_gap);

module x_cylinder(x, y, r, h) {
    translate([x, y, 0]) rotate([0, 90, 0]) cylinder(r = r, h = h);
}

// s = -1 lower, +1 upper
module knuckle(i, s, ax_y = hinge_axis_y, web_y = hinge_web_y, x0 = knuckle_x0) {
    x = x0 + i * (knuckle_len + knuckle_gap);
    x_cylinder(x, ax_y, knuckle_r, knuckle_len);
    difference() {
        intersection() {
            hull() {
                x_cylinder(x, ax_y, knuckle_r, knuckle_len);
                translate([x, web_y, s * (ax_y - web_y + knuckle_r * sqrt(2))])
                    cube([knuckle_len, 0.01, 0.01], center = false);
            }
            if (s < 0) below_parting(); else above_parting();
        }
        if (!$coupon)
            translate([0, 0, -20]) linear_extrude(height = 40) cavity_2d();
    }
}

module knuckle_clearance(i, ax_y = hinge_axis_y, x0 = knuckle_x0) {
    x_cylinder(x0 + i * (knuckle_len + knuckle_gap) - knuckle_gap / 2, ax_y,
               knuckle_r + knuckle_clearance, knuckle_len + knuckle_gap);
}

// Teardrop pin hole; tip_up = true for a part printed as modelled (lower),
// false for one printed flipped (upper)
module pin_hole(d = pin_d, tip_up = true, ax_y = hinge_axis_y, x0 = knuckle_x0) {
    translate([x0 - 1, ax_y, 0])
        rotate([0, 90, 0])
            linear_extrude(height = hinge_len + 2)
                rotate(tip_up ? 180 : 0)
                    hull() {
                        circle(d = d);
                        translate([d / 2 * sqrt(2), 0]) square(0.01, center = true);
                    }
}

// -----------------------------------------------------------------------------
// Magnet lugs
// -----------------------------------------------------------------------------
mag_pocket_r = (mag_d + mag_clear) / 2;
// Magnet centre back to the cavity line (matches how mag_lugs were placed)
mag_root = (mag_d + 0.15) / 2 + 0.5;

// Lug footprint, local +X = outward wall normal
module lug_2d(L) {
    translate([L[0], L[1]]) rotate(L[2])
        hull() {
            circle(r = lug_r);
            translate([-mag_root - 1, -lug_root_w / 2]) square([1, lug_root_w]);
        }
}

// Lug from the seam to +-lug_flat, then a 45 deg taper back to the wall line
// so it prints without supports. s = -1 lower, +1 upper.
module lug(L, s) {
    drop = mag_root + lug_r;
    difference() {
        hull() {
            translate([0, 0, s < 0 ? -lug_flat : 0])
                linear_extrude(height = lug_flat) lug_2d(L);
            translate([L[0], L[1], s * (lug_flat + drop)]) rotate(L[2])
                translate([-mag_root, -lug_root_w / 2, 0]) cube([0.01, lug_root_w, 0.01]);
        }
        translate([0, 0, -20]) linear_extrude(height = 40) cavity_2d();
    }
}

module mag_pocket(L, s) {
    h = mag_h + mag_depth_extra;
    translate([L[0], L[1], s < 0 ? -h : -0.01])
        cylinder(r = mag_pocket_r, h = h + 0.01);
}

// Polarity dot on the lower lug's outer face: glue every lower magnet the same
// way up, every upper magnet the other way up
module polarity_dot(L) {
    translate([L[0], L[1], -1.2]) rotate(L[2])
        translate([lug_r - 0.3, 0, 0]) rotate([0, 90, 0]) cylinder(d = 1.2, h = 1);
}

// The locator tongue and slot stop short of the lugs; the magnet pockets
// reach into their band
module lug_zones() {
    translate([0, 0, -5]) linear_extrude(height = 10)
        for (L = mag_lugs) offset(r = 0.5) lug_2d(L);
}

// -----------------------------------------------------------------------------
// Lower Part (Z <= 0)
// -----------------------------------------------------------------------------
module lower_half_flat() {
    intersection() {
        base_model();
        below_parting();
    }
}

module lower_half_press_fit() {
    difference() {
        union() {
            lower_half_flat();
            intersection() {
                belt();
                below_parting();
            }
            tongue();
            ribs();
        }
        pry_notch();
    }
}

module lower_half_snap() {
    difference() {
        union() {
            lower_half_flat();
            intersection() {
                for (l = snap_latches) latch_pad(l);
                below_parting();
            }
        }
        for (l = snap_latches) latch_pocket(l);
    }
}

module lower_half_hinge() {
    difference() {
        union() {
            lower_half_flat();
            knuckle(0, -1);
            knuckle(2, -1);
            intersection() {
                for (l = hinge_latches) latch_pad(l, hinge_latch_swing);
                below_parting();
            }
        }
        knuckle_clearance(1);
        pin_hole(tip_up = true);
        for (l = hinge_latches) latch_pocket(l, hinge_latch_swing);
    }
}

module lower_half_magnet() {
    difference() {
        union() {
            lower_half_flat();
            intersection() {
                belt();
                below_parting();
            }
            difference() {
                tongue();
                lug_zones();
            }
            for (L = mag_lugs) lug(L, -1);
        }
        pry_notch();
        for (L = mag_lugs) {
            mag_pocket(L, -1);
            polarity_dot(L);
        }
    }
}

// KIA logo outline: the holes the engraving leaves in the lower face, 0.1 mm
// inside it, grown 0.02 mm (rounded) so the deeper cut never shares a wall
// with the engraving
module kia_2d() {
    offset(r = 0.02)
        difference() {
            translate(kia_box[0]) square(kia_box[1] - kia_box[0]);
            projection(cut = true)
                translate([0, 0, face_z - 0.1])
                    base_model();
        }
}

// KIA logo cut kia_depth into the lower face
module kia_cut() {
    translate([0, 0, -face_z - 0.01])
        linear_extrude(height = kia_depth + 0.01) kia_2d();
}

// Flush inlay that fills kia_cut()
module kia_inlay() {
    translate([0, 0, -face_z])
        linear_extrude(height = kia_depth) kia_2d();
}

module lower_all() {
    difference() {
        if (joint_style == "press_fit") {
            lower_half_press_fit();
        } else if (joint_style == "snap") {
            lower_half_snap();
        } else if (joint_style == "hinge") {
            lower_half_hinge();
        } else if (joint_style == "magnet") {
            lower_half_magnet();
        } else {
            lower_half_flat();
        }
        kia_cut();
    }
}

// Lower half ("all" or "body"), or its KIA logo inlay ("kia")
module part_lower(which = colour_part) {
    if (which == "kia")
        kia_inlay();
    else
        lower_all();
}

// -----------------------------------------------------------------------------
// Upper Part (Z >= 0)
// -----------------------------------------------------------------------------
module upper_half_flat() {
    intersection() {
        base_model();
        above_parting();
    }
}

module upper_half_press_fit() {
    difference() {
        union() {
            upper_half_flat();
            intersection() {
                belt();
                above_parting();
            }
        }
        slot();
    }
}

// B3D Labs logo outline on the upper face
module logo_2d() {
    translate(logo_center)
        resize([0, logo_height], auto = true)
            import(logo_file, center = true);
}

// Logo cut logo_depth into the flat outer face (Z = top of the model)
module logo_cut() {
    translate([0, 0, face_z - logo_depth])
        linear_extrude(height = logo_depth + 0.01) logo_2d();
}

// Flush inlay that fills logo_cut()
module logo_inlay() {
    translate([0, 0, face_z - logo_depth])
        linear_extrude(height = logo_depth) logo_2d();
}

// Upper half with wall pads, arm slots and arms for latches ls
module upper_with_latches(ls, swing = 0) {
    union() {
        difference() {
            union() {
                upper_half_flat();
                intersection() {
                    for (l = ls) latch_pad(l, swing);
                    above_parting();
                }
            }
            for (l = ls) latch_slot(l);
        }
        for (l = ls) latch_arm(l);
    }
}

module upper_half_snap() {
    upper_with_latches(snap_latches);
}

module upper_half_hinge() {
    difference() {
        union() {
            upper_with_latches(hinge_latches, hinge_latch_swing);
            knuckle(1, 1);
        }
        knuckle_clearance(0);
        knuckle_clearance(2);
        pin_hole(tip_up = false);
    }
}

module upper_half_magnet() {
    difference() {
        union() {
            upper_half_flat();
            intersection() {
                belt();
                above_parting();
            }
            for (L = mag_lugs) lug(L, 1);
        }
        difference() {
            slot(mag_tongue_clearance);
            lug_zones();
        }
        for (L = mag_lugs) mag_pocket(L, 1);
    }
}

module upper_all() {
    difference() {
        if (joint_style == "press_fit") {
            upper_half_press_fit();
        } else if (joint_style == "snap") {
            upper_half_snap();
        } else if (joint_style == "hinge") {
            upper_half_hinge();
        } else if (joint_style == "magnet") {
            upper_half_magnet();
        } else {
            upper_half_flat();
        }
        if (logo) logo_cut();
    }
}

// Upper half ("all" or "body"), or its B3D Labs logo inlay ("kia")
module part_upper(which = colour_part) {
    if (which == "kia") {
        if (logo) logo_inlay();
    } else
        upper_all();
}

// -----------------------------------------------------------------------------
// Test Coupon
// -----------------------------------------------------------------------------
// Straight 20 mm section of the joint: one lower and one upper per clearance,
// both laid out outer face down. The wall runs along X; the cavity side is +Y.
// Uppers are engraved with the clearance in hundredths (05 / 10 / 15).

// Lower: floor + wall with the tongue and ribs on top, wall top at Z = 0
module coupon_lower() {
    translate([0, 0, coupon_wall_h])
    union() {
        translate([0, 0, -coupon_wall_h])
            cube([coupon_len, min_wall, coupon_wall_h]);
        translate([0, 0, -coupon_wall_h])
            cube([coupon_len, coupon_floor_w, coupon_floor_t]);
        // Tongue: inner tongue_w of the wall
        taper_top(0, tongue_h, lead_in)
            translate([0, min_wall - tongue_w + $inset])
                square([coupon_len, tongue_w - $inset]);
        // Ribs on the tongue's outer face
        taper_top(0, tongue_h - lead_in, rib_height)
            for (x = [4 : 6 : coupon_len - 4])
                intersection() {
                    translate([x, min_wall - tongue_w]) circle(r = rib_r);
                    translate([x - rib_r, min_wall - tongue_w - rib_height + $inset])
                        square([2 * rib_r, rib_height - $inset]);
                }
    }
}

// Upper: floor + wall with the slot, printed slot up
module coupon_upper(c) {
    translate([0, 0, coupon_wall_h])
    difference() {
        union() {
            translate([0, 0, -coupon_wall_h])
                cube([coupon_len, min_wall, coupon_wall_h]);
            translate([0, 0, -coupon_wall_h])
                cube([coupon_len, coupon_floor_w, coupon_floor_t]);
        }
        // Slot, chamfered mouth at the top
        mirror([0, 0, 1])
            translate([0, 0, -0.01])
                taper_bottom(0, tongue_h + slot_extra_depth + 0.01, slot_chamfer)
                    translate([-1, min_wall - tongue_w - c - $inset])
                        square([coupon_len + 2, tongue_w + c + $inset + 1]);
        // Clearance label on the floor's inner face
        translate([coupon_len / 2, min_wall + (coupon_floor_w - min_wall) / 2,
                   -coupon_wall_h + coupon_floor_t - 0.4])
            linear_extrude(height = 1)
                text(str(round(c * 100) < 10 ? "0" : "", round(c * 100)),
                     size = 3, halign = "center", valign = "center");
    }
}

module part_coupon_press_fit() {
    for (i = [0 : len(coupon_clearances) - 1]) {
        translate([0, i * (coupon_floor_w + 4), 0])
            coupon_lower();
        translate([coupon_len + 5, i * (coupon_floor_w + 4), 0])
            coupon_upper(coupon_clearances[i]);
    }
}

// Snap: straight 14 mm wall section, rim and end posts as on the case. Modelled
// assembled (seam at Z = 0), then laid out for printing; the lower carries the
// retaining-face angle engraved on its rim.
// Lower block: 1.2 mm floor under the pocket, up to the side windows' bottom
coupon_snap_base = pocket_bottom - 1.2;
// Upper block: from the arm's free length up, 4.8 mm tall
coupon_snap_top = arm_free_z + 4.8;

module coupon_snap_lower(ang) {
    translate([0, 0, -coupon_snap_base])
    difference() {
        union() {
            translate([-7, 0, coupon_snap_base])
                cube([14, 6, -4.2 - coupon_snap_base]);
            for (x = [-7, 5]) translate([x, 0, -4.21]) cube([2, 1.7, 4.21]);
        }
        let($coupon = true) latch_pocket([0, 0, 0], 0, ang);
        translate([0, 4.2, -4.6])
            linear_extrude(height = 1)
                text(str(ang), size = 1.8, halign = "center", valign = "center");
    }
}

module coupon_snap_upper(ang) {
    translate([0, 0, coupon_snap_top])
    mirror([0, 0, 1])
    union() {
        translate([-7, 0, arm_free_z]) cube([14, 6, coupon_snap_top - arm_free_z]);
        for (x = [-7, 5]) translate([x, 0, 0]) cube([2, 1.7, arm_free_z + 0.01]);
        let($coupon = true) latch_arm([0, 0, 0], ang);
    }
}

// Hinge: two blocks with the case's knuckles; the lower carries pin_d
coupon_hinge_ax = 6 + knuckle_r - knuckle_overlap;

module coupon_hinge_lower(d) {
    translate([0, 0, 7])
    let($coupon = true)
    difference() {
        union() {
            translate([-1, 0, -7]) cube([hinge_len + 2, 6, 7]);
            knuckle(0, -1, coupon_hinge_ax, 5, 0);
            knuckle(2, -1, coupon_hinge_ax, 5, 0);
        }
        knuckle_clearance(1, coupon_hinge_ax, 0);
        pin_hole(d, true, coupon_hinge_ax, 0);
        translate([hinge_len / 2, 2.2, -0.4])
            linear_extrude(height = 1)
                text(str(d), size = 1.6, halign = "center", valign = "center");
    }
}

module coupon_hinge_upper(d) {
    translate([0, 0, 7])
    mirror([0, 0, 1])
    let($coupon = true)
    difference() {
        union() {
            translate([-1, 0, 0]) cube([hinge_len + 2, 6, 7]);
            knuckle(1, 1, coupon_hinge_ax, 5, 0);
        }
        knuckle_clearance(0, coupon_hinge_ax, 0);
        knuckle_clearance(2, coupon_hinge_ax, 0);
        pin_hole(d, false, coupon_hinge_ax, 0);
    }
}

// Magnet: one pocket per clearance, engraved in hundredths (10 = 5.10 mm)
module coupon_magnet(c) {
    floor_t = 1.2;
    difference() {
        cube([9, 13, floor_t + mag_h]);
        translate([4.5, 4.5, floor_t - mag_depth_extra])
            cylinder(d = mag_d + c, h = mag_h + 1);
        translate([4.5, 10.5, floor_t + mag_h - 0.4])
            linear_extrude(height = 1)
                text(str(round(c * 100)), size = 2.5, halign = "center", valign = "center");
    }
}

module part_coupon() {
    if (joint_style == "snap") {
        for (i = [0 : len(coupon_hook_angles) - 1]) {
            translate([i * 18, 0, 0]) coupon_snap_lower(coupon_hook_angles[i]);
            translate([i * 18, 10, 0]) coupon_snap_upper(coupon_hook_angles[i]);
        }
    } else if (joint_style == "hinge") {
        for (i = [0 : len(coupon_pin_ds) - 1]) {
            translate([i * 16, 0, 0]) coupon_hinge_lower(coupon_pin_ds[i]);
            translate([i * 16, 14, 0]) coupon_hinge_upper(coupon_pin_ds[i]);
        }
    } else if (joint_style == "magnet") {
        for (i = [0 : len(coupon_mag_clears) - 1])
            translate([i * 12, 0, 0]) coupon_magnet(coupon_mag_clears[i]);
    } else {
        part_coupon_press_fit();
    }
}

// -----------------------------------------------------------------------------
// Assembly and Display Logic
// -----------------------------------------------------------------------------
if (part == "upper") {
    part_upper();
} else if (part == "lower") {
    part_lower();
} else if (part == "coupon") {
    part_coupon();
} else if (part == "exploded") {
    // Exploded view: Lower on bed, Upper elevated above
    color([0.20, 0.45, 0.85, 1.0])
        part_lower("body");
    color([0.95, 0.95, 0.95, 1.0])
        part_lower("kia");

    translate([0, 0, exploded_offset]) {
        color([0.90, 0.45, 0.20, 0.9])
            part_upper("body");
        color([0.95, 0.95, 0.95, 1.0])
            part_upper("kia");
    }
} else {
    // Assembled view
    color([0.20, 0.45, 0.85, 1.0])
        part_lower("body");
    color([0.95, 0.95, 0.95, 1.0])
        part_lower("kia");

    color([0.90, 0.45, 0.20, 0.9])
        part_upper("body");
    color([0.95, 0.95, 0.95, 1.0])
        part_upper("kia");
}
