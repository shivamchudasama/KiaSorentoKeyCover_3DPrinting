// Kia Sorento Key Case - pin hinge with snap latches
// Thin wrapper: all geometry and parameters live in the master source,
// ../Original/split.scad.
// Edit them there; this file only fixes joint_style.
// Pick the part and colour here, or on the command line with
// -D 'part="lower"' -D 'colour_part="kia"'.

include <../Original/split.scad>

/* [Render Options] */
part = "assembly"; // ["assembly", "exploded", "upper", "lower", "coupon"]
joint_style = "hinge";
colour_part = "all"; // ["all", "body", "kia"]
