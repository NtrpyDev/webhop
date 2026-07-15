# webhop

CS2 maps running in a browser tab with real movement physics. Air strafing, autobhop, scroll jump, surf-style wall slides, all simulated at 128 tick with the actual CS2 movement constants (friction 5.2, airaccel 12, 301.99 jump impulse). Every official map works; press M in-game to switch.

No game engine, no server. Three.js for rendering, [three-mesh-bvh](https://github.com/gkjohnson/three-mesh-bvh) for capsule collision against the real map collision mesh, and a few hundred lines of Quake-lineage movement math.

Inspired by [Luke Parker](https://github.com/Hona) porting TF2 to the browser. Shares no code with his project, but the idea of "source engine map, playable in a tab" is his.

## What's in here

- `viewer/play.html` - the playable demo. Pointer lock, WASD, scroll wheel or space to jump (hold space for autobhop), M for the map selector, T for third person, V for noclip, R to reset, [ and ] to adjust mouse sensitivity (CS units, so bring your real sens). `?map=de_mirage`, `?sens=1.2`, `?tick=64` also work as URL params.
- `viewer/index.html` - orbit-camera map viewer with spawn/bombsite markers.
- `batch-export.sh` - exports collision meshes and entities for every official map in one run.
- `parse-entities.py` - converts the exported entity lumps into the entities.json the viewer reads spawns from.
- `shot.mjs` - headless screenshot helper (Playwright).

Two render modes: default is a wireframe hologram of the collision mesh, `?render=textured` loads the full textured map. Collision always runs on the physics mesh, so movement is identical in both.

## Map data is not included

The dust2 geometry and textures are Valve's, so you export them yourself from your own CS2 install using [Source2Viewer CLI](https://github.com/ValveResourceFormat/ValveResourceFormat/releases) (drop it in `tools/`):

To export everything at once, edit the Steam path at the top of `batch-export.sh`, run it, then run `python3 parse-entities.py`. Or by hand for one map:

```sh
# collision mesh (wireframe mode, required)
tools/Source2Viewer-CLI -i "<steam>/Counter-Strike Global Offensive/game/csgo/maps/de_dust2.vpk" \
  -f "maps/de_dust2/world_physics.vmdl_c" -d -o export --gltf_export_format glb

# full textured map (optional, ~1GB)
tools/Source2Viewer-CLI -i "<steam>/Counter-Strike Global Offensive/game/csgo/maps/de_dust2.vpk" \
  -f "maps/de_dust2/world.vwrld_c" -d -o export-textured --gltf_export_format glb \
  --gltf_export_materials --gltf_textures_adapt

# player model (optional, for third person)
tools/Source2Viewer-CLI -i "<steam>/Counter-Strike Global Offensive/game/csgo/pak01_dir.vpk" \
  -f "agents/models/ctm_sas/ctm_sas.vmdl_c" -d -o export --gltf_export_format glb --gltf_export_animations
```

Then serve the repo root and open the viewer:

```sh
python -m http.server 8471
# http://127.0.0.1:8471/viewer/play.html
```

Other maps work the same way, swap `de_dust2` for any map VPK. Entity markers and spawn point are dust2-only for now.

## Known jank

- The player model slides around in a fixed pose. CS2's movement animations live in its animgraph system, which doesn't survive the glTF export.
- Textured mode is unlit (fullbright). Real CS2 lighting is baked lightmaps this pipeline doesn't extract.
- First person arms (`?arms=1`) are bind-pose mannequin arms. It's exactly as cursed as it sounds.
- No step-height logic. Stairs work because Source maps cover them with invisible clip ramps, which is how the real game does it anyway.

## License

MIT for the code in this repo. Map geometry, textures, and models belong to Valve.
