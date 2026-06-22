#!/usr/bin/env bash
# Package each plugin into a single zip in dist/, for distribution via GitHub
# releases and manual upload to Claude.ai (which accepts Skills but not Claude
# Code plugins).
#
# For each plugin we produce one archive, <plugin>-v<version>.zip, that contains
# that plugin's skills as individual, self-contained zips (<skill>-<version>.zip).
# You download the one plugin zip, extract it, and upload each skill zip inside
# to Claude.ai (which accepts one skill per upload). Each skill zip carries any
# plugin-level shared references/ (at <skill>/references/) so it works on its
# own; that copy happens in a temp dir, leaving the source tree untouched.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dist="$repo_root/dist"
mkdir -p "$dist"

shopt -s nullglob
for plugin_dir in "$repo_root"/plugins/*/; do
  plugin_json="$plugin_dir.claude-plugin/plugin.json"
  plugin_name="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["name"])' "$plugin_json")"
  version="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$plugin_json")"
  shared_refs="${plugin_dir%/}/references"
  # Build the per-skill zips into a temp dir; only the plugin zip lands in dist/.
  work="$(mktemp -d)"
  skill_zips=()
  for skill_dir in "$plugin_dir"skills/*/; do
    skill_name="$(basename "$skill_dir")"
    out="$work/${skill_name}-${version}.zip"
    # Stage the skill so plugin-level shared references can be bundled inside it
    # without mutating the source tree.
    stage="$(mktemp -d)"
    cp -R "${skill_dir%/}" "$stage/$skill_name"
    if [ -d "$shared_refs" ]; then
      mkdir -p "$stage/$skill_name/references"
      # -n: never clobber a skill's own reference of the same name.
      cp -Rn "$shared_refs/." "$stage/$skill_name/references/"
    fi
    (cd "$stage" && zip -qr "$out" "$skill_name")
    rm -rf "$stage"
    skill_zips+=("$(basename "$out")")
  done
  if [ "${#skill_zips[@]}" -gt 0 ]; then
    bundle="$dist/${plugin_name}-v${version}.zip"
    rm -f "$bundle"
    (cd "$work" && zip -qr "$bundle" "${skill_zips[@]}")
    echo "packaged $bundle (${#skill_zips[@]} skill$([ "${#skill_zips[@]}" -ne 1 ] && echo s))"
  fi
  rm -rf "$work"
done
