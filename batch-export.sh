#!/bin/bash
# Export collision mesh + entities for every official CS2 map.
MAPS_DIR="/mnt/shared/SteamLibrary/steamapps/common/Counter-Strike Global Offensive/game/csgo/maps"
cd "$(dirname "$0")"
for vpk in "$MAPS_DIR"/*.vpk; do
  name=$(basename "$vpk" .vpk)
  case "$name" in
    *vanity*|lobby_*|workshop_*|graphics_*) continue ;;
  esac
  if [ ! -f "export/maps/$name/world_physics_physics.glb" ]; then
    echo "=== $name: physics"
    tools/Source2Viewer-CLI -i "$vpk" -f "maps/$name/world_physics.vmdl_c" -d -o export --gltf_export_format glb >/dev/null 2>&1
  fi
  if [ ! -f "export/maps/$name/entities/default_ents.vents" ]; then
    echo "=== $name: entities"
    tools/Source2Viewer-CLI -i "$vpk" -f "maps/$name/entities/default_ents.vents_c" -d -o export >/dev/null 2>&1
  fi
done
echo "BATCH DONE"
ls export/maps/
