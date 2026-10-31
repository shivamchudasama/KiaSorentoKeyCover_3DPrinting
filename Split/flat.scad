// Kia Sorento Key Case - plain split, no joint
// Thin wrapper: all geometry and parameters live in the master source,
// ../Original/split.scad.
// Edit them there; this file only fixes joint_style.
// Pick the part here, or on the command line with -D 'part="upper"'.

include <../Original/split.scad>

/* [Render Options] */
part = "assembly"; // ["assembly", "exploded", "upper", "lower"]
joint_style = "flat";
