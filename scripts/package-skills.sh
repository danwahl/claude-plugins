#!/usr/bin/env bash
# Package each plugin's skills as individual zips in dist/, suitable for
# uploading to Claude.ai (which accepts Skills but not Claude Code plugins).
#
# Skills are shipped self-contained: any plugin-level shared references/ are
# bundled into each skill zip (at <skill>/references/) so the zip works on its
# own. The canonical references stay single-source in the plugin; the copy
# happens at package time in a temp dir, leaving the working tree untouched.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dist="$repo_root/dist"
mkdir -p "$dist"

shopt -s nullglob
for plugin_dir in "$repo_root"/plugins/*/; do
  plugin_json="$plugin_dir.claude-plugin/plugin.json"
  version="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$plugin_json")"
  shared_refs="${plugin_dir%/}/references"
  for skill_dir in "$plugin_dir"skills/*/; do
    skill_name="$(basename "$skill_dir")"
    out="$dist/${skill_name}-${version}.zip"
    rm -f "$out"
    # Stage the skill in a temp dir so plugin-level shared references can be
    # bundled inside it without mutating the source tree.
    stage="$(mktemp -d)"
    cp -R "${skill_dir%/}" "$stage/$skill_name"
    if [ -d "$shared_refs" ]; then
      mkdir -p "$stage/$skill_name/references"
      # -n: never clobber a skill's own reference of the same name.
      cp -Rn "$shared_refs/." "$stage/$skill_name/references/"
    fi
    (cd "$stage" && zip -qr "$out" "$skill_name")
    rm -rf "$stage"
    echo "packaged $out"
  done
done
