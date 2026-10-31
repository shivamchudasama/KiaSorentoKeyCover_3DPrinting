# Kia Sorento Key Case

A 3D-printable two-part case for the Kia Sorento digital key fob, designed in OpenSCAD for **ASA**. The case splits at its mid-plane so the fob drops in. The two halves then close with one of three tool-free joints, and every joint can be opened again for battery changes.

> **Status:** designed and checked in CAD (no collisions when closed, hooks engage, hinge sweeps clear), but **not yet print-tested**. Print the test coupons first.

## Choose a joint

| Joint | How it holds | How to open | Extra parts |
|---|---|---|---|
| **Snap** | 4 flexible arms hang from the upper half through the side windows and hook into notches in the lower rim | Lever each arm out with a fingernail (a slot sits beside each arm) | none |
| **Hinge** | Pin hinge at the closed (top) end, plus 2 snap latches near the open end | Release the 2 latches and swing open like a book | 1.75 mm filament offcut, ~11 mm |
| **Magnet** | 4 external lugs at the seam, each holding a pair of magnets; a small tongue around the seam stops sliding | Pull apart | 8× 5 × 2 mm neodymium magnets, CA glue |

The magnet lugs stick out about 5.5 mm from the case outline. The case walls are at most ~2 mm thick, so a 5 mm magnet can't fit inside them. The hinge adds a bump of about 4.5 mm at the top end.

An earlier **press-fit** joint (tongue and slot with crush ribs) is still in the source as `joint_style = "press_fit"`. It relies on friction and came out too loose in practice, so it isn't recommended.

## Files

| File | What it is |
|---|---|
| `kia_sorento_key_case_{snap,hinge,magnet}_upper.stl` | Upper half (with logo) |
| `kia_sorento_key_case_{snap,hinge,magnet}_lower.stl` | Lower half |
| `kia_sorento_key_case_{snap,hinge,magnet}_coupon.stl` | Small test pieces for that joint |
| `kia_sorento_key_case_{snap,hinge,magnet}_assembly.glb` | Coloured 3D preview of the closed case (magnets and pin included). Opens in Windows 3D Viewer, Blender, or any glTF viewer |
| `kia_sorento_key_case_split.scad` | Parametric source for all of the above |
| `kia_sorento_key_case_from_openscad.stl` | Unsplit base case the source builds on |
| `B3D_Labs.svg` | Logo debossed into the upper half |

The other files (`kia_sorento_key_case_digital_only.*`, `kia_sorento_key_case_{upper,lower}_flat.stl`) are earlier steps: the base case with the mechanical-key slot removed, and a plain split with no joint.

## Printing

- **Material:** ASA, which the clearances were chosen for. Other materials are untested.
- **Orientation:** print both halves **outer face down**. Flip the upper half 180° in the slicer. The STLs are exported in assembled position.
- **Supports:** none needed. Hinge knuckles, magnet lugs and latch overhangs are all tapered at 45°.
- **Coupons first.** Each coupon tests the one setting that is hardest to predict:

  | Coupon | Variants | What to pick |
  |---|---|---|
  | Snap | Hook retaining-face angle **90 / 60 / 45°** (engraved) | 90° locks until the arm is levered out; 60° and 45° pull apart by hand. Pick the one that holds but still opens comfortably |
  | Hinge | Pin hole **1.80 / 1.85 / 1.90 mm** (engraved) | The tightest hole your 1.75 mm filament still turns in freely |
  | Magnet | Pocket **5.10 / 5.20 / 5.30 mm** (engraved `10` / `20` / `30`) | The tightest pocket the magnet still presses into |

  Enter the chosen value in OpenSCAD (`hook_return_angle`, `pin_d`, or `mag_clear`), export the halves, then print.

## Assembly

**Snap:** Put the fob in the lower half and press the upper half straight down until all four arms click. The hooks slide lightly along the fob's sides on the way in. To open, lever each arm outward with a fingernail and lift.

**Hinge:** Line up the knuckles and push a 1.75 mm filament offcut through. Melt each end slightly with a soldering iron or lighter so it can't slide out. Close the case on the fob until both latches click.

**Magnet:**
1. Glue the four magnets into the **lower** half with CA, all with the **same pole facing up**. A small dot on each lower lug's outer face marks the lower half.
2. Let a loose magnet snap onto one of the glued ones and mark its exposed top face with a pen. Repeat for the other three.
3. Glue each marked magnet into the **upper** half **marked face first**, so the mark ends up at the bottom of the pocket.
4. Let the glue cure before closing the case. Each pair now attracts.

## Customising

Open `kia_sorento_key_case_split.scad` in [OpenSCAD](https://openscad.org/) (a recent nightly build; the manifold backend renders each part in about 2 s). The Customizer groups every setting:

- **Render Options:** `part` = `assembly` / `exploded` / `upper` / `lower` / `coupon`, and `joint_style`.
- **Snap Latches, Hinge, Magnets:** dimensions and clearances for each joint.
- **Logo:** turn the deboss on or off, or swap the SVG.

Command-line export example:

```sh
openscad --backend=manifold -D 'joint_style="snap"' -D 'part="upper"' -o upper.stl kia_sorento_key_case_split.scad
```

Export as ASCII STL (the default). Binary STL rounds coordinates to 32-bit floats and introduces mesh errors in these parts.

**Known issue:** the magnet halves (and the legacy press-fit halves) contain a few non-manifold edges, which come from the press-fit tongue geometry they reuse. Bambu Studio and most other slicers repair these automatically on import. The snap and hinge parts are clean.

## Credits

- Case design, split and joints: B3D Labs.
- Base case model: _TODO — add the original model's source and licence before publishing._
