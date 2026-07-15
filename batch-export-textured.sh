#!/bin/bash
# Export the full textured visual mesh for every official CS2 map (~1GB each).
MAPS_DIR="/mnt/shared/SteamLibrary/steamapps/common/Counter-Strike Global Offensive/game/csgo/maps"
cd "$(dirname "$0")"
for vpk in "$MAPS_DIR"/*.vpk; do
  name=$(basename "$vpk" .vpk)
  case "$name" in
    *vanity*|lobby_*|workshop_*|graphics_*) continue ;;
  esac
  if [ -f "export-textured/maps/$name/world.glb" ]; then continue; fi
  echo "=== $name"
  tools/Source2Viewer-CLI -i "$vpk" -f "maps/$name/world.vwrld_c" -d -o export-textured \
    --gltf_export_format glb --gltf_export_materials --gltf_textures_adapt >/dev/null 2>&1
done
echo "TEXTURED BATCH DONE"
du -sh export-textured