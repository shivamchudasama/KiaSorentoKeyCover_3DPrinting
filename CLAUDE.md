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
  - `split.scad` — **the master source**. `joint_style` = `press_fit` (legacy, too loose in practice) / `snap` / `hinge` / `magnet` / `flat`; `part` = `assembly` / `exploded` / `upper` / `lower` / `coupon`; `colour_part` = `all` / `body` (the same here) / `kia` (the KIA logo inlay for the lower half; the upper gives nothing). Coupons are joint-specific.
  - `split_grip_ridge.scad` — **exploratory copy** of the master that adds grip ridges to the snap, hinge and magnet halves: one pair round the top arc, one along the open end (`grip_ridge_top` / `grip_ridge_end`). The hinge is pinned at the top arc, so it gets only the end pair (`grip_ridges(top = false)`). Changes to `split.scad` must be carried into it by hand.
  - `split_rugged.scad` — **styled copy** of the master (orange seam band on the posts, grey corner bumpers, debossed face styling, logo inlay). `split_trail.scad` — **styled copy** built from the rugged one (orange side-window frames, top-left cap, right tab, boot over the open end; flush panel in a sunken border with stipple). Both cover snap/hinge/magnet, add `accent` to `colour_part` (`all` / `body` / `accent` / `kia`) for two-colour (AMS) prints, and keep the joints unchanged. Changes to `split.scad` must be carried into both by hand.
  - `from_openscad.stl` — unsplit base case that every master `import()`s. Geometrically identical to `digital_only.stl`.
  - `digital_only.scad` — earlier step that cut the mechanical-key slot off the original case. Leave it as is; its input (`kia_sorento_key_case_raw.stl`) is deliberately not part of the repo.
  - `B3D_Labs.svg` — logo debossed into the upper face.
- `Snap/`, `Hinge/`, `Magnet/`, `Split/` — one folder per design, each with a **wrapper** `.scad` (`snap.scad`, `hinge.scad`, `magnet.scad`, `flat.scad`; `<joint>_ridge.scad`, `<joint>_rugged.scad`, `<joint>_trail.scad` for the copies) that `include`s `../Original/<master>.scad`, then reassigns `part`, `joint_style` and `colour_part` (last assignment wins; `-D` on the command line still overrides them). Wrappers hold no parameters — edit the master. Relative paths in the master's `import()`s resolve against `Original/`.
  - `<joint>_{upper,lower,coupon}.stl` — exports, in assembled position (the upper half is flipped in the slicer). `<joint>_ridge_{upper,lower}.stl` in `Snap/`, `Hinge/` and `Magnet/`. The styled ones are `<joint>_{rugged,trail}_{upper,lower}.stl` (body, `colour_part="body"`) plus `..._accent.stl` (`colour_part="accent"`). Every lower half also has `..._lower_kia.stl` (`colour_part="kia"`): `<joint>_lower_kia.stl`, `<joint>_{ridge,rugged,trail}_lower_kia.stl`.
  - `<joint>_assembly.glb`, `<joint>_{ridge,rugged,trail}_assembly.glb` — coloured previews (styled ones: body and accent as separate meshes; every one has a `kia` node, white, orange on rugged) built with trimesh from the exported STLs, plus visual-only magnets (5 × 2 mm) and hinge pin. Y-up, metres. No script is checked in; regenerate them whenever the STLs change (easiest: load the old GLB, swap the upper/lower meshes, keep materials, node transforms and pin).
  - `Split/{upper,lower}_flat.stl` — old plain-split exports: binary STL, no logo. `flat.scad` reproduces them geometrically only with `-D logo=false`.

## Conventions

- **Geometry read from the STL is hard-coded** with a comment saying so: `rib_points`, `snap_latches` / `hinge_latches`, `mag_lugs` (magnet centres 0.5 mm + pocket radius off the cavity along the wall normal), `apex_y`, `face_z` (outer face plates, ±10.302), `kia_box` (box round the KIA logo). Recompute them if the base STL or the parameters they depend on change.
- Key measurements: the side windows span Z −4.2 … +4.2, leaving four posts 0.7–1.6 mm thick across the seam, and no wall is thicker than ~2 mm. Fob cavity Z ±8.65. The open end (Y = 0) has no wall in the window band, and a fob slot at |Z| < 5.6. This is why friction joints fail here and why the magnets need external lugs.
- **The side windows expose the fob's buttons — never cover them.** Latches go on the wall posts only (Z = 0 slice: left post Y 0–16.3, right lower post Y 0–30, top-arc post from Y 48.9 on the left round to X 28, right upper post Y 57.4–64.6). Check every change with the window-overlap test.
- Latches are `[x, y, outward normal angle]` or `[x, y, angle, arm width]`: a point on the cavity line and its wall normal. Each latch is built in its own `latch_frame()` with axis-aligned boxes and rotated once in 3D; rotating a box in 2D leaves non-manifold slivers.
- Each latch gets a **wall pad** (`latch_pad()`) that thickens the wall outward to `pad_t`, so the pocket is enclosed with `latch_skin` left outside it. The pad starts 0.2 mm inside the wall to avoid coincident faces, and chamfers 45° into the face plates. Hooks release by pulling (`hook_return_angle` = 60°); there is no nail slot on the case.
- Latch features are strips between two `cavity_2d()` offsets, cut to a box. In the coupons, `$coupon = true` swaps in a straight wall along X and adds an open pocket with a nail slot.
- Both halves print outer face down, so overhangs get 45° chamfers via `ramp()`.
- The hinge webs are clipped to their own half (z ≥ 0 for the upper, z ≤ 0 for the lower). A web that crosses the seam sweeps into the other half when the case opens.
- **Styled copies.** Their additions (`rugged_add()` / `style_add()`) go inside each joint's union **before** its cuts, so slots, pockets and pin holes still cut through them. Nothing may stand above ±`face_z` (both halves print face down): face styling is debossed, bumpers/caps/boot end flush with the face. Their positions are hard-coded from the STL like the latches: `band_keeps` / `window_holes` (post ends and window openings at the outer face), `bumpers`, `caps`, `boot_poly`, and the open end's fob slot (`slot_z` 5.67, `slot_x`, and its roof ramping up at ~30°, `slot_ramp`). Face styling keeps clear of the KIA logo on the lower face (X 3.9–24, Y 5–10).
- **Colour split:** `body = all − accent_zone()`, `accent = all ∩ accent_zone()`. The zone is cut `accent_margin` past the accent parts' ends and stops short of the latch pads and magnet lugs (`block_2d()`), which stay body colour.
- **KIA logo:** the base model engraves it only 0.2 mm deep in the lower face. `kia_2d()` traces it from the STL (the holes in a `projection(cut = true)` 0.1 mm inside the face, within `kia_box`, grown `offset(r = 0.02)` so no wall coincides with the engraving's). `kia_cut()` deepens it to `kia_depth` (0.6) in `lower_all()` of every master, and `kia_inlay()` is the separate `kia` part that fills it, outside the body/accent split. It is deliberately not drawn from an SVG (different proportions; filling the old recess would leave coincident faces). On trail it spans the orange boot and latch A's black clip, so it needs a third colour.
- **Avoiding broken faces** (each of these produced degenerate triangles once):
  - Never make a new face coincide with an existing one. `cavity_2d()` is exactly the posts' inner faces, so trim to `offset(r = 0.3) cavity_2d()`, not to it.
  - Use **rounded** (`offset(r = …)`) inner edges for rings next to delta-offset geometry: two `delta` offsets of the same outline share miter lines, and a vertical edge piercing a face exactly on one of them degenerates.
  - Build a stepped `ramp()` stack unclipped and clip it **once** with a prism. Clipping each slice leaves end faces whose 0.001 mm overlaps degenerate where they cross the wall.

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
  - for the hinge, rotating the upper half about `hinge_axis_y` from 3° to 120° stays empty;
  - styled copies: rays from the cavity line out along the wall normal (±15°) at |Z| < 4.2 that escape the plain case also escape the styled one (radial rays from the middle graze the band/frame ends beside a window and aren't a fair test); and `vol(body) + vol(accent) = vol(all)` with zero overlap (rugged upper: plus the logo inlay);
  - KIA inlay: it intersects body and accent with zero volume, and `vol(body) + vol(accent) + vol(kia)` exceeds the previous export by exactly the old 0.2 mm engraving (9.607 mm³). A trimesh union of body and accent trips over their shared faces, so don't use it.
- For booleans, `include` a copy of the master (placed in `Original/` so its relative imports resolve) with the trailing "Assembly and Display Logic" block stripped (otherwise its top-level dispatch renders too). trimesh's manifold engine refuses the magnet halves (not volumes), so run their booleans in OpenSCAD this way.
- Known: the `magnet` and `press_fit` halves have non-manifold edges that come from the `belt()`/`tongue()`/`slot()` geometry; slicers repair them. `snap` and `hinge` are clean, in every copy; the styled magnet halves have fewer such edges than the plain ones, and all accent parts are clean.

## Git

Public GitHub repo (`origin` = `shivamchudasama/KiaSorentoKeyCover_3DPrinting`), single branch `main`.

- `.gitattributes` routes `*.stl`, `*.3mf`, `*.pdf` and `*.glb` to **Git LFS**. `*.png` stays an ordinary blob by policy. Add any new binary extension there **before** its first commit.
- The current STL/GLB exports total ~120 MB; with superseded versions, LFS storage is ~160 MB, against the free tier of 1 GB storage / 1 GB monthly bandwidth. Re-exporting one styled variant (body + accent STLs and GLBs for all three joints) writes ~39 MB into LFS; a plain re-export ~18 MB; re-exporting every lower half and GLB (as for the KIA inlay) ~59 MB. Commit exports when a design settles, not on every experiment.
- `.gitignore` excludes `.codex/` (local tool config).
- README still has a TODO crediting the original base-case model and its licence.
