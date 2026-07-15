#!/usr/bin/env python3
"""Convert every exported map's default_ents.vents into entities.json with spawns."""
import re, json, glob, os

KEEP = {"info_player_terrorist", "info_player_counterterrorist", "func_bomb_target", "info_hostage_spawn"}

for vents in glob.glob("export/maps/*/entities/default_ents.vents"):
    map_dir = os.path.dirname(os.path.dirname(vents))
    out = []
    txt = open(vents, errors="replace").read()
    for block in txt.split("\n\n"):
        kv = dict(re.findall(r"^(\w+)\s+(.+)$", block, re.M))
        cls = kv.get("classname", "").strip('"')
        if cls in KEEP and "origin" in kv:
            origin = [float(x) for x in re.findall(r"-?[\d.]+", kv["origin"])]
            angles = [float(x) for x in re.findall(r"-?[\d.]+", kv.get("angles", "0 0 0"))]
            out.append({"classname": cls, "origin": origin, "angles": angles})
    with open(os.path.join(map_dir, "entities.json"), "w") as f:
        json.dump(out, f)
    n_t = sum(1 for e in out if e["classname"] == "info_player_terrorist")
    print(f"{os.path.basename(map_dir)}: {len(out)} entities ({n_t} T spawns)")
