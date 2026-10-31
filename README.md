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

## Files

Each design has its own folder; the shared source lives in `Original/`.

| Folder | Contents |
|---|---|
| `Snap/`, `Hinge/`, `Magnet/` | `<joint>_{upper,lower,coupon}.stl`: upper half (with logo), lower half, and small test pieces for that joint. `<joint>_assembly.glb`: coloured 3D preview of the closed case (magnets and pin included), which opens in Windows 3D Viewer, Blender, or any glTF viewer |
| `Snap/`, `Hinge/` | `<joint>_ridge_*`: an experimental variant with grip ridges for pulling the halves apart |
| `Split/` | `{upper,lower}_flat.stl`: an earlier plain split with no joint (and no logo) |
| `Original/` | `split.scad`: the parametric source for every design. `split_grip_ridge.scad`: its grip-ridge copy. `from_openscad.stl`: the unsplit base case the source builds on. `B3D_Labs.svg`: the logo debossed into the upper half. `digital_only.*`: the earlier step that removed the mechanical-key slot |

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

Command-line export example:

```sh
openscad --backend=manifold -D 'joint_style="snap"' -D 'part="upper"' -o upper.stl Original/split.scad
# or, through the design's wrapper:
openscad --backend=manifold -D 'part="upper"' -o Snap/snap_upper.stl Snap/snap.scad
```

Export as ASCII STL (the default). Binary STL rounds coordinates to 32-bit floats and introduces mesh errors in these parts.

**Known issue:** the magnet halves (and the legacy press-fit halves) contain a few non-manifold edges, which come from the press-fit tongue geometry they reuse. Bambu Studio and most other slicers repair these automatically on import. The snap and hinge parts are clean.

## Credits

- Case design, split and joints: B3D Labs.
- Base case model: _TODO — add the original model's source and licence before publishing._
