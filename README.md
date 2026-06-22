# danwahl-claude-plugins

Personal Claude Code plugin marketplace.

## Installation

### Claude Code (plugins)

Add this marketplace, then browse or install a specific plugin:

```
/plugin marketplace add danwahl/claude-plugins
/plugin                                              # browse everything
/plugin install learning-lab@danwahl-claude-plugins  # or a specific plugin
```

### Claude.ai (skills)

Claude.ai doesn't support Claude Code plugins, but it does accept Skills uploaded as zips. Each [release](https://github.com/danwahl/claude-plugins/releases) attaches a self-contained zip per skill — download the one you want and upload it manually in Claude.ai. (To build the zips yourself instead, see [Building skill zips locally](#building-skill-zips-locally).)

## Plugins

| Plugin | Description |
|--------|-------------|
| `writing-audit` | Audit and sharpen writing using craft principles. Invoke with `/writing-audit:writing-audit`. |
| `learning-lab` | Evidence-based AI-assisted learning. Start with `/learning-lab:tutor` to plan how to learn anything; or invoke a technique directly: `:socratic-method`, `:feynman-method`, `:retrieval-quiz`, `:spaced-repetition`, `:learning-experiment`. |

## Adding a new plugin

1. Create a directory under `plugins/your-plugin-name/`
2. Add `.claude-plugin/plugin.json` with at minimum `name` and `version`
3. Add skills under `skills/your-skill-name/SKILL.md`
4. Add the plugin entry to `.claude-plugin/marketplace.json`
5. Bump versions and push

## Testing locally

Test any plugin before publishing:

```bash
claude --plugin-dir ./plugins/your-plugin-name
```

Then invoke with `/your-plugin-name:skill-name`.

## Building skill zips locally

Releases attach the skill zips automatically, but to build them yourself run `/package-skills` (or `scripts/package-skills.sh`). It writes one self-contained zip per skill under `dist/` (gitignored), ready to upload to Claude.ai.

## Versioning

Uses semantic versioning (MAJOR.MINOR.PATCH). Bump the version in both `plugin.json` and `marketplace.json` — Claude Code uses the version to determine whether to update, so unchanged versions won't propagate.

## Releasing

Pushing a `v*` tag triggers [`.github/workflows/release.yml`](.github/workflows/release.yml), which builds the skill zips from the tagged source and attaches them to the GitHub release (notes auto-generated). So cutting a release is just:

```bash
git tag v1.2.0
git push origin v1.2.0
```

Tag the marketplace version, and make sure the per-plugin versions are bumped first so Claude Code picks up the update.
