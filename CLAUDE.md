# CLAUDE.md

## Routine

After a **significant change** — one that makes something in this file wrong or incomplete (files added/renamed/reorganized, a new convention adopted, git/LFS setup changed) — say which section is affected and ask:

> Would you like to modify `CLAUDE.md` accordingly?

Do not ask on turns that change nothing here (questions, inspection, small edits that fit existing conventions). Keep this file lean — only what's needed to understand the repo.

## Repository nature

A single **parametric OpenSCAD design**: a two-part ASA case for the Kia Sorento digital key fob, split at Z = 0 and joined by a selectable tool-free joint. No build system, no test runner, no dependency manifest — do not fabricate build/lint/test commands. Verification is done by hand (see **Verifying changes**). Nothing has been print-tested yet; the coupons exist for that.

## Layout

Flat folder, no subdirectories (apart from a local `.codex/` tool config).

- `kia_sorento_key_case_split.scad` — **the source**. `joint_style` = `press_fit` (legacy, too loose in practice) / `snap` / `hinge` / `magnet` / `flat`; `part` = `assembly` / `exploded` / `upper` / `lower` / `coupon`. Coupons are joint-specific.
- `kia_sorento_key_case_from_openscad.stl` — unsplit base case that the source `import()`s. Geometrically identical to `kia_sorento_key_case_digital_only.stl`.
- `kia_sorento_key_case_digital_only.scad` — earlier step that cut the mechanical-key slot off the original case. Leave it as is; its input is deliberately not part of the repo.
- `kia_sorento_key_case_{upper,lower}_flat.stl` — old plain-split exports.
- `kia_sorento_key_case_{snap,hinge,magnet}_{upper,lower,coupon}.stl` — exports of the source, in assembled position (the upper half is flipped in the slicer).
- `kia_sorento_key_case_{snap,hinge,magnet}_assembly.glb` — coloured previews built with trimesh from the exported STLs, plus visual-only magnets (5 × 2 mm) and hinge pin. Y-up, metres. No script is checked in; regenerate them whenever the STLs change.
- `B3D_Labs.svg` — logo debossed into the upper face.

## Conventions

- **Geometry read from the STL is hard-coded** with a comment saying so: `rib_points`, `mag_lugs` (magnet centres 0.5 mm + pocket radius off the cavity along the wall normal), `apex_y`, `top_z` in `logo_cut()`. Recompute them if the base STL or the parameters they depend on change.
- Key measurements: the side windows span Z −4.2 … +4.2, leaving four posts 0.7–1.6 mm thick across the seam, and no wall is thicker than ~2 mm. Fob cavity Z ±8.65. The open end (Y = 0) has no wall in the window band. This is why friction joints fail here and why the magnets need external lugs.
- Latches are `[side, y, nail]` (side −1 = left wall, +1 = right; `nail` = which side of the arm gets the fingernail slot). An arm can slide into its own nail slot, so **pair opposite `nail` sides on each wall** or the snap halves slide along Y.
- Latch features are strips between two `cavity_2d()` offsets, cut to a box. In the coupons, `$coupon = true` swaps in a straight wall along X.
- The hinge webs are clipped to their own half (z ≥ 0 for the upper, z ≤ 0 for the lower). A web that crosses the seam sweeps into the other half when the case opens.

## Verifying changes

- OpenSCAD: `"C:/Program Files/OpenSCAD (Nightly)/openscad.com" --backend=manifold` (~2 s per part).
- Export **ASCII STL** (the default). `--export-format binstl` rounds to float32 and breaks manifoldness.
- Checks used so far:
  - every part renders, is watertight, and is a single body (trimesh);
  - `intersection(){ part_upper(); part_lower(); }` is empty or zero-volume when assembled;
  - lifting the upper half 0.1 mm makes the hooks overlap (the lock is real);
  - shifting it ±0.4 mm in X/Y collides;
  - for the hinge, rotating the upper half about `hinge_axis_y` from 3° to 120° stays empty.
- For booleans, `include` a copy of the source with the trailing "Assembly and Display Logic" block stripped (otherwise its top-level dispatch renders too).
- Known: the `magnet` and `press_fit` halves have non-manifold edges that come from the `belt()`/`tongue()`/`slot()` geometry; slicers repair them. `snap` and `hinge` are clean.

## Git

Public GitHub repo (`origin` = `shivamchudasama/KiaSorentoKeyCover_3DPrinting`), single branch `main`.

- `.gitattributes` routes `*.stl`, `*.3mf`, `*.pdf` and `*.glb` to **Git LFS**. `*.png` stays an ordinary blob by policy. Add any new binary extension there **before** its first commit.
- About 22 MB of STL/GLB is in LFS, against the free tier of 1 GB storage / 1 GB monthly bandwidth. Re-exporting every joint's parts and GLBs writes another ~18 MB into LFS each time, so commit exports when a design settles, not on every experiment.
- `.gitignore` excludes `.codex/` (local tool config).
- README still has a TODO crediting the original base-case model and its licence.
