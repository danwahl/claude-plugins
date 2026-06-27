# claude-plugins

Personal Claude Code plugin marketplace by [danwahl](https://github.com/danwahl).

## Installation

### Claude Code (plugins)

Add this marketplace, then browse or install a specific plugin:

```
/plugin marketplace add danwahl/claude-plugins
/plugin                                              # browse everything
/plugin install learning-lab@danwahl-claude-plugins  # or a specific plugin
```

### Claude.ai (skills)

Claude.ai doesn't support Claude Code plugins, but it does accept Skills uploaded as zips. Each [release](https://github.com/danwahl/claude-plugins/releases) attaches one zip per plugin, `<plugin>-v<version>.zip` (e.g. `learning-lab-v0.1.0.zip`). Download it and extract it to get that plugin's skills as individual, self-contained zips, then upload each in Claude.ai — it accepts one skill per upload.

(To build the zips yourself instead, see [Building the zips locally](#building-the-zips-locally).)

Note on persistence: `learning-lab` saves plans, decks, and logs to your filesystem in Claude Code, but Claude.ai runs skills in a per-conversation sandbox with no durable storage. There it falls back to emitting each document as a saveable artifact — keep it and paste it back at the start of your next session to resume.

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

## Building the zips locally

Releases attach the plugin zips automatically, but to build them yourself run `/package-skills` (or `scripts/package-skills.sh`). It writes one `<plugin>-v<version>.zip` per plugin under `dist/` (gitignored); each contains that plugin's skills as individual zips ready to upload to Claude.ai.

## Versioning

Uses semantic versioning (MAJOR.MINOR.PATCH). Bump the version in both `plugin.json` and `marketplace.json` — Claude Code uses the version to determine whether to update, so unchanged versions won't propagate.

## Releasing

Pushing a `v*` tag triggers [`.github/workflows/release.yml`](.github/workflows/release.yml), which builds the plugin zips from the tagged source and attaches them to the GitHub release (notes auto-generated). So cutting a release is just:

```bash
git tag v1.2.0
git push origin v1.2.0
```

Tag the marketplace version, and make sure the per-plugin versions are bumped first so Claude Code picks up the update.
