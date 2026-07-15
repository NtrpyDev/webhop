# webhop

CS2 maps running in a browser tab with real movement physics. Air strafing, autobhop, scroll jump, surf-style wall slides, all simulated at 128 tick with the actual CS2 movement constants (friction 5.2, airaccel 12, 301.99 jump impulse).

No game engine, no server. Three.js for rendering, [three-mesh-bvh](https://github.com/gkjohnson/three-mesh-bvh) for capsule collision against the real map collision mesh, and a few hundred lines of Quake-lineage movement math.

Inspired by [Luke Parker](https://github.com/Hona) porting TF2 to the browser. Shares no code with his project, but the idea of "source engine map, playable in a tab" is his.

## Maps

All the current competitive/premier maps plus a few classics: dust2, mirage, inferno, nuke, overpass, ancient, anubis, train, vertigo, cache, italy, office, shelter, pool day. Press M in-game to switch. Any other map VPK exports the same way if you want it.

## Controls

| input | action |
|---|---|
| click canvas | grab the mouse (pointer lock) |
| WASD + mouse | move / look |
| scroll wheel or space | jump. hold space to autobhop |
| G | toggle wireframe / textured (remembered) |
| M | map selector |
| T | third person |
| V | noclip |
| R | reset to spawn |
| [ and ] | mouse sensitivity down / up |

Sensitivity is in CS units (`sens * 0.022` degrees per count), so set the number you use in game and it feels the same at the same DPI. It persists, or force it with `?sens=1.2`.

URL params: `?map=de_mirage`, `?render=textured`, `?sens=1.2`, `?tick=64` (default 128).

## What's in here

- `viewer/play.html` - the playable demo.
- `viewer/index.html` - orbit-camera map viewer with spawn/bombsite markers.
- `batch-export.sh` - exports collision meshes and entities for every official map in one run.
- `batch-export-textured.sh` - exports the full textured meshes (about 1GB per map, only needed for textured mode).
- `parse-entities.py` - converts the exported entity lumps into the entities.json the viewer reads spawns from.
- `shot.mjs` - headless screenshot helper (Playwright).

Wireframe mode renders the collision mesh as a hologram. Textured mode renders the real visual mesh unlit (fullbright), since CS2's baked lightmaps don't survive the export. Collision always runs on the physics mesh, so movement is identical in both.

## Map data is not included

The geometry and textures are Valve's, so you export them yourself from your own CS2 install using [Source2Viewer CLI](https://github.com/ValveResourceFormat/ValveResourceFormat/releases) (drop it in `tools/`):

```sh
# edit the Steam path at the top of each script first
./batch-export.sh            # collision + entities for all maps (required, ~3GB)
python3 parse-entities.py    # spawn points for the viewer
./batch-export-textured.sh   # textured meshes (optional, ~20GB for all maps)
```

Then serve the repo root and play:

```sh
python -m http.server 8471
# http://127.0.0.1:8471/viewer/play.html
```

The player model (optional, T for third person) exports with:

```sh
tools/Source2Viewer-CLI -i "<steam>/Counter-Strike Global Offensive/game/csgo/pak01_dir.vpk" \
  -f "agents/models/ctm_sas/ctm_sas.vmdl_c" -d -o export --gltf_export_format glb --gltf_export_animations
```

## Known jank

- The player model slides around in a fixed pose. CS2's movement animations live in its animgraph system, which doesn't survive the glTF export.
- Textured mode is unlit. Decal overlays (graffiti, bombsite paint) are approximated with multiply blending because their alpha lives in a shader glTF can't express.
- First person arms (`?arms=1`) are bind-pose mannequin arms. It's exactly as cursed as it sounds.
- No step-height logic. Stairs work because Source maps cover them with invisible clip ramps, which is how the real game does it anyway.

## License

MIT for the code in this repo. Map geometry, textures, and models belong to Valve.
