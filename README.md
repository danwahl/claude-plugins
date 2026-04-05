# danwahl-claude-plugins

Personal Claude Code plugin marketplace.

## Setup

Add this marketplace to Claude Code:

```
/plugin marketplace add danwahl/claude-plugins
```

Then browse available plugins:

```
/plugin
```

Or install a specific plugin:

```
/plugin install writing-audit@danwahl-claude-plugins
```

## Plugins

| Plugin | Description |
|--------|-------------|
| `writing-audit` | Audit and sharpen writing using craft principles. Invoke with `/writing-audit:writing-audit`. |

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

## Versioning

Uses semantic versioning (MAJOR.MINOR.PATCH). Bump the version in both `plugin.json` and `marketplace.json` — Claude Code uses the version to determine whether to update, so unchanged versions won't propagate.
