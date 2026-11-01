// Kia Sorento Key Case - magnet joint, rugged styling
// Thin wrapper: all geometry and parameters live in the master source,
// ../Original/split_rugged.scad.
// Edit them there; this file only fixes joint_style.
// Pick the part and colour here, or on the command line with
// -D 'part="upper"' -D 'colour_part="body"'.

include <../Original/split_rugged.scad>

/* [Render Options] */
part = "assembly"; // ["assembly", "exploded", "upper", "lower", "coupon"]
joint_style = "magnet";
colour_part = "all"; // ["all", "body", "accent", "kia"]
