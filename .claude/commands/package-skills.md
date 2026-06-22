---
description: Package each plugin into a versioned zip in dist/ for manual upload to Claude.ai
---

Run `scripts/package-skills.sh` from the repo root and report which zips were produced (or any errors). The output directory is `dist/` (gitignored). It writes one `<plugin>-v<version>.zip` per plugin, each containing that plugin's skills as individual zips for uploading to Claude.ai, which does not support Claude Code plugins directly.

!`bash scripts/package-skills.sh`
