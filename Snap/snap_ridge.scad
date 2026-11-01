// Kia Sorento Key Case - snap-latch joint with grip ridges
// Thin wrapper: all geometry and parameters live in the master source,
// ../Original/split_grip_ridge.scad.
// Edit them there; this file only fixes joint_style.
// Pick the part and colour here, or on the command line with
// -D 'part="lower"' -D 'colour_part="kia"'.

include <../Original/split_grip_ridge.scad>

/* [Render Options] */
part = "assembly"; // ["assembly", "exploded", "upper", "lower", "coupon"]
joint_style = "snap";
colour_part = "all"; // ["all", "body", "kia"]
