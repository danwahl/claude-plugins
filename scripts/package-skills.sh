#!/usr/bin/env bash
# Package each plugin's skills as individual zips in dist/, suitable for
# uploading to Claude.ai (which accepts Skills but not Claude Code plugins).
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dist="$repo_root/dist"
mkdir -p "$dist"

shopt -s nullglob
for plugin_dir in "$repo_root"/plugins/*/; do
  plugin_json="$plugin_dir.claude-plugin/plugin.json"
  version="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$plugin_json")"
  for skill_dir in "$plugin_dir"skills/*/; do
    skill_name="$(basename "$skill_dir")"
    out="$dist/${skill_name}-${version}.zip"
    rm -f "$out"
    (cd "$plugin_dir/skills" && zip -qr "$out" "$skill_name")
    echo "packaged $out"
  done
done
