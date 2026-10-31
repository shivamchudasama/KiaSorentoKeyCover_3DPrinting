# Kia Sorento Key Case

A 3D-printable two-part case for the Kia Sorento digital key fob, designed in OpenSCAD for **ASA**. The case splits at its mid-plane so the fob drops in. The two halves then close with one of three tool-free joints, and every joint can be opened again for battery changes.

> **Status:** designed and checked in CAD (no collisions when closed, hooks engage, hinge sweeps clear), but **not yet print-tested**. Print the test coupons first.

## Choose a joint

| Joint | How it holds | How to open | Extra parts |
|---|---|---|---|
| **Snap** | 4 flexible arms hang from the upper half on the solid wall sections (the side windows stay clear for the fob's buttons) and hook into notches in the lower rim. The wall is thickened into a small pad around each arm, so the arms are hidden | Pull the halves apart (60° hooks) | none |
| **Hinge** | Pin hinge at the closed (top) end, plus 2 snap latches near the open end, in the same wall pads | Pull the open end apart and swing open like a book | 1.75 mm filament offcut, ~11 mm |
| **Magnet** | 4 external lugs at the seam, each holding a pair of magnets; a small tongue around the seam stops sliding | Pull apart | 8× 5 × 2 mm neodymium magnets, CA glue |

The magnet lugs stick out about 5.5 mm from the case outline. The case walls are at most ~2 mm thick, so a 5 mm magnet can't fit inside them. The hinge adds a bump of about 4.5 mm at the top end. The latch pads stand about 1.1–2.1 mm proud of the wall.

An earlier **press-fit** joint (tongue and slot with crush ribs) is still in the source as `joint_style = "press_fit"`. It relies on friction and came out too loose in practice, so it isn't recommended.

## Rugged variant

Every joint also comes in a **rugged** style. The fit and the joint are the same as the plain case; only the outside changes:

- an orange **bumper band** round the seam, on the solid wall sections only, so the side buttons stay uncovered. The grey latch pads and magnet lugs cross it and stand slightly proud of it;
- grey **corner bumpers**, flush with the outer faces. Their flat edges towards the seam give your fingers something to pull on when opening the case;
- **debossed styling**:
  - front: a bezel round the window, a panel with three slots, grip lines either side, and the logo low on the panel;
  - back: a hexagonal emblem with a keyhole, plus the same bezel, panel and grip lines.

The case grows about 1.5 mm per side at the band (more at the magnet lugs) and keeps its 20.6 mm thickness. It's designed for **two colours** on a multi-material printer (Bambu AMS or similar), with the front logo as a flush orange inlay. It also prints in a single colour; see **Printing**.

## Trail variant

A second styled version, also for every joint and also two-colour (black and orange). It has no seam band. Instead it has:

- a raised orange **frame round each side window**. It stands 0.5 mm back from the opening, so the buttons stay as easy to reach as on the plain case;
- an orange **cap wrapping the top-left corner** for the full height of the case, and a small **tab** on the right side above the window;
- an orange **boot** over the open end and its two corners, with the logo debossed in its front. The fob's slot at the end stays open. On the left, latch A's black pad crosses the boot like a clip;
- on both faces, a **flush central panel** in a sunken border, with **stippled grip zones** either side and a groove round the window. The stipple dots stand up from the border flush with the face, so they print on the bed.

Everything stays flush with the outer faces, so both halves still print flat, face down, without supports.

## Files

Each design has its own folder; the shared source lives in `Original/`.

| Folder | Contents |
|---|---|
| `Snap/`, `Hinge/`, `Magnet/` | `<joint>_{upper,lower,coupon}.stl`: upper half (with logo), lower half, and small test pieces for that joint. `<joint>_assembly.glb`: coloured 3D preview of the closed case (magnets and pin included), which opens in Windows 3D Viewer, Blender, or any glTF viewer |
| `Snap/`, `Hinge/`, `Magnet/` | `<joint>_ridge_*`: an experimental variant with grip ridges for pulling the halves apart: round the top arc and along the open end (the hinge, pinned at the top arc, has only the open-end pair) |
| `Snap/`, `Hinge/`, `Magnet/` | `<joint>_rugged_{upper,lower}.stl` (grey body) and `<joint>_rugged_{upper,lower}_accent.stl` (orange band and logo inlay): the rugged variant. `<joint>_rugged_assembly.glb`: its two-colour preview |
| `Snap/`, `Hinge/`, `Magnet/` | `<joint>_trail_{upper,lower}.stl` (black body), `<joint>_trail_{upper,lower}_accent.stl` (orange frames, cap, tab and boot) and `<joint>_trail_assembly.glb`: the trail variant |
| `Split/` | `{upper,lower}_flat.stl`: an earlier plain split with no joint (and no logo) |
| `Original/` | `split.scad`: the parametric source for every design. `split_grip_ridge.scad`, `split_rugged.scad` and `split_trail.scad`: its grip-ridge, rugged and trail copies. `from_openscad.stl`: the unsplit base case the sources build on. `B3D_Labs.svg`: the logo debossed into the upper half. `digital_only.*`: the earlier step that removed the mechanical-key slot |

Each design folder also has a small `.scad` file (for example `Snap/snap.scad`) that includes the master source from `Original/` and fixes `joint_style`. Open it to work on that design alone. Every parameter still lives in the master, so a change there reaches all designs.

## Printing

- **Material:** ASA, which the clearances were chosen for. Other materials are untested.
- **Orientation:** print both halves **outer face down**. Flip the upper half 180° in the slicer. The STLs are exported in assembled position.
- **Supports:** none needed. Hinge knuckles, magnet lugs and latch overhangs are all tapered at 45°.
- **Coupons first.** Each coupon tests the one setting that is hardest to predict:

  | Coupon | Variants | What to pick |
  |---|---|---|
  | Snap | Hook retaining-face angle **90 / 60 / 45°** (engraved) | 60° and 45° pull apart by hand; pick the one that holds but still opens comfortably. 90° only opens by levering the arm out through the coupon's nail slot; on the case the arms are enclosed, so 90° would never open |
  | Hinge | Pin hole **1.80 / 1.85 / 1.90 mm** (engraved) | The tightest hole your 1.75 mm filament still turns in freely |
  | Magnet | Pocket **5.10 / 5.20 / 5.30 mm** (engraved `10` / `20` / `30`) | The tightest pocket the magnet still presses into |

  Enter the chosen value in OpenSCAD (`hook_return_angle`, `pin_d`, or `mag_clear`), export the halves, then print.

- **Rugged and trail variants, two colours:** load each half's body STL and its `_accent` STL together. In Bambu Studio, when asked whether to load them as a single object with multiple parts, answer **yes**. Then give the accent part the second filament. The parts fit together exactly, with no gaps or overlaps. Expect some purge waste:
  - **Rugged:** colour changes happen in the first ~3 layers (logo inlay) and the last ~5 mm of each half (band).
  - **Trail:** the boot's and cap's orange face skin covers the first 5 layers. The boot, cap and window frames then run most of the height, so most layers need a colour change.
- **One colour:** load the body and accent STLs as one object and print in one filament. Alternatively, export `colour_part = "all"`, which gives the half as one STL; on the rugged variant the logo is then debossed instead of inlaid.

## Assembly

**Snap:** Put the fob in the lower half and press the upper half straight down until all four arms click. The hooks slide lightly along the fob's sides on the way in. To open, pull the halves apart.

**Hinge:** Line up the knuckles and push a 1.75 mm filament offcut through. Melt each end slightly with a soldering iron or lighter so it can't slide out. Close the case on the fob until both latches click.

**Magnet:**
1. Glue the four magnets into the **lower** half with CA, all with the **same pole facing up**. A small dot on each lower lug's outer face marks the lower half.
2. Let a loose magnet snap onto one of the glued ones and mark its exposed top face with a pen. Repeat for the other three.
3. Glue each marked magnet into the **upper** half **marked face first**, so the mark ends up at the bottom of the pocket.
4. Let the glue cure before closing the case. Each pair now attracts.

## Customising

Open `Original/split.scad` in [OpenSCAD](https://openscad.org/) (a recent nightly build; the manifold backend renders each part in about 2 s). The Customizer groups every setting:

- **Render Options:** `part` = `assembly` / `exploded` / `upper` / `lower` / `coupon`, and `joint_style`.
- **Snap Latches, Hinge, Magnets:** dimensions and clearances for each joint.
- **Logo:** turn the deboss on or off, or swap the SVG.

The rugged variant lives in `Original/split_rugged.scad`, a copy of `split.scad` with three more groups: **Rugged Band**, **Bumpers** and **Face Styling**. Its **Render Options** gain `colour_part` = `all` / `body` / `accent`. The trail variant lives in `Original/split_trail.scad`, with the same `colour_part` and the groups **Window Frames**, **Caps and Boot**, **Colour Split** and **Face Styling**. Its wrappers are `<Joint>/<joint>_trail.scad`.

Command-line export example:

```sh
openscad --backend=manifold -D 'joint_style="snap"' -D 'part="upper"' -o upper.stl Original/split.scad
# or, through the design's wrapper:
openscad --backend=manifold -D 'part="upper"' -o Snap/snap_upper.stl Snap/snap.scad
# rugged body and accent:
openscad --backend=manifold -D 'part="upper"' -D 'colour_part="body"' -o Snap/snap_rugged_upper.stl Snap/snap_rugged.scad
openscad --backend=manifold -D 'part="upper"' -D 'colour_part="accent"' -o Snap/snap_rugged_upper_accent.stl Snap/snap_rugged.scad
```

Export as ASCII STL (the default). Binary STL rounds coordinates to 32-bit floats and introduces mesh errors in these parts.

**Known issue:** the magnet halves (and the legacy press-fit halves) contain a few non-manifold edges, which come from the press-fit tongue geometry they reuse. Bambu Studio and most other slicers repair these automatically on import. The snap and hinge parts are clean, and so are all the rugged and trail accent parts. The rugged and trail magnet halves have fewer of these edges than the plain ones.

## Credits

- Case design, split and joints: B3D Labs.
- Base case model: _TODO — add the original model's source and licence before publishing._
