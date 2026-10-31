# CLAUDE.md

## Routine

After a **significant change** — one that makes something in this file wrong or incomplete (files added/renamed/reorganized, a new convention adopted, git/LFS setup changed) — say which section is affected and ask:

> Would you like to modify `CLAUDE.md` accordingly?

Do not ask on turns that change nothing here (questions, inspection, small edits that fit existing conventions). Keep this file lean — only what's needed to understand the repo.

## Repository nature

A single **parametric OpenSCAD design**: a two-part ASA case for the Kia Sorento digital key fob, split at Z = 0 and joined by a selectable tool-free joint. No build system, no test runner, no dependency manifest — do not fabricate build/lint/test commands. Verification is done by hand (see **Verifying changes**). Nothing has been print-tested yet; the coupons exist for that.

## Layout

One folder for the shared source and one per design (plus a local `.codex/` tool config). File names carry no `kia_sorento_key_case_` prefix; exports keep the design name (`snap_upper.stl`) so parts stay distinct when loaded together.

- `Original/` — everything shared:
  - `split.scad` — **the master source**. `joint_style` = `press_fit` (legacy, too loose in practice) / `snap` / `hinge` / `magnet` / `flat`; `part` = `assembly` / `exploded` / `upper` / `lower` / `coupon`. Coupons are joint-specific.
  - `split_grip_ridge.scad` — **exploratory copy** of the master that adds grip ridges to the snap and hinge halves: one pair round the top arc, one along the open end (`grip_ridge_top` / `grip_ridge_end`). Changes to `split.scad` must be carried into it by hand.
  - `from_openscad.stl` — unsplit base case that both masters `import()`. Geometrically identical to `digital_only.stl`.
  - `digital_only.scad` — earlier step that cut the mechanical-key slot off the original case. Leave it as is; its input (`kia_sorento_key_case_raw.stl`) is deliberately not part of the repo.
  - `B3D_Labs.svg` — logo debossed into the upper face.
- `Snap/`, `Hinge/`, `Magnet/`, `Split/` — one folder per design, each with a **wrapper** `.scad` (`snap.scad`, `hinge.scad`, `magnet.scad`, `flat.scad`; `snap_ridge.scad` / `hinge_ridge.scad` for the grip-ridge master) that `include`s `../Original/<master>.scad`, then reassigns `part` and `joint_style` (last assignment wins). Wrappers hold no parameters — edit the master. Relative paths in the master's `import()`s resolve against `Original/`.
  - `<joint>_{upper,lower,coupon}.stl` — exports, in assembled position (the upper half is flipped in the slicer). `<joint>_ridge_{upper,lower}.stl` in `Snap/` and `Hinge/`.
  - `<joint>_assembly.glb`, `<joint>_ridge_assembly.glb` — coloured previews built with trimesh from the exported STLs, plus visual-only magnets (5 × 2 mm) and hinge pin. Y-up, metres. No script is checked in; regenerate them whenever the STLs change (easiest: load the old GLB, swap the upper/lower meshes, keep materials, node transforms and pin).
  - `Split/{upper,lower}_flat.stl` — old plain-split exports: binary STL, no logo. `flat.scad` reproduces them geometrically only with `-D logo=false`.

## Conventions

- **Geometry read from the STL is hard-coded** with a comment saying so: `rib_points`, `snap_latches` / `hinge_latches`, `mag_lugs` (magnet centres 0.5 mm + pocket radius off the cavity along the wall normal), `apex_y`, `face_z` (outer face plates, ±10.302). Recompute them if the base STL or the parameters they depend on change.
- Key measurements: the side windows span Z −4.2 … +4.2, leaving four posts 0.7–1.6 mm thick across the seam, and no wall is thicker than ~2 mm. Fob cavity Z ±8.65. The open end (Y = 0) has no wall in the window band, and a fob slot at |Z| < 5.6. This is why friction joints fail here and why the magnets need external lugs.
- **The side windows expose the fob's buttons — never cover them.** Latches go on the wall posts only (Z = 0 slice: left post Y 0–16.3, right lower post Y 0–30, top-arc post from Y 48.9 on the left round to X 28, right upper post Y 57.4–64.6). Check every change with the window-overlap test.
- Latches are `[x, y, outward normal angle]` or `[x, y, angle, arm width]`: a point on the cavity line and its wall normal. Each latch is built in its own `latch_frame()` with axis-aligned boxes and rotated once in 3D; rotating a box in 2D leaves non-manifold slivers.
- Each latch gets a **wall pad** (`latch_pad()`) that thickens the wall outward to `pad_t`, so the pocket is enclosed with `latch_skin` left outside it. The pad starts 0.2 mm inside the wall to avoid coincident faces, and chamfers 45° into the face plates. Hooks release by pulling (`hook_return_angle` = 60°); there is no nail slot on the case.
- Latch features are strips between two `cavity_2d()` offsets, cut to a box. In the coupons, `$coupon = true` swaps in a straight wall along X and adds an open pocket with a nail slot.
- Both halves print outer face down, so overhangs get 45° chamfers via `ramp()`.
- The hinge webs are clipped to their own half (z ≥ 0 for the upper, z ≤ 0 for the lower). A web that crosses the seam sweeps into the other half when the case opens.

## Verifying changes

- OpenSCAD: `"C:/Program Files/OpenSCAD (Nightly)/openscad.com" --backend=manifold` (~2 s per part). Export through the wrapper, e.g. `-D 'part="upper"' -o Snap/snap_upper.stl Snap/snap.scad`.
- Renders are deterministic: an unchanged design re-exports **byte-identical** to the committed snap/hinge/magnet STLs, so `cmp` against them proves a refactor changed nothing.
- Export **ASCII STL** (the default). `--export-format binstl` rounds to float32 and breaks manifoldness.
- Checks used so far:
  - every part renders, is watertight, and is a single body (trimesh);
  - window overlap: the side-window volume (convex hull of the posts minus cavity and posts, |Z| < 4.2) intersected with each half adds nothing beyond the slivers next to the posts;
  - `intersection(){ part_upper(); part_lower(); }` is empty or zero-volume when assembled;
  - lifting the upper half 0.1 mm makes the hooks overlap (the lock is real);
  - shifting it ±0.4 mm in X/Y collides;
  - for the hinge, rotating the upper half about `hinge_axis_y` from 3° to 120° stays empty.
- For booleans, `include` a copy of the master (placed in `Original/` so its relative imports resolve) with the trailing "Assembly and Display Logic" block stripped (otherwise its top-level dispatch renders too).
- Known: the `magnet` and `press_fit` halves have non-manifold edges that come from the `belt()`/`tongue()`/`slot()` geometry; slicers repair them. `snap` and `hinge` are clean.

## Git

Public GitHub repo (`origin` = `shivamchudasama/KiaSorentoKeyCover_3DPrinting`), single branch `main`.

- `.gitattributes` routes `*.stl`, `*.3mf`, `*.pdf` and `*.glb` to **Git LFS**. `*.png` stays an ordinary blob by policy. Add any new binary extension there **before** its first commit.
- About 22 MB of STL/GLB is in LFS, against the free tier of 1 GB storage / 1 GB monthly bandwidth. Re-exporting every joint's parts and GLBs writes another ~18 MB into LFS each time, so commit exports when a design settles, not on every experiment.
- `.gitignore` excludes `.codex/` (local tool config).
- README still has a TODO crediting the original base-case model and its licence.
