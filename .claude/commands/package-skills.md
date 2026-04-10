---
description: Package each plugin's skills as zips in dist/ for manual upload to Claude.ai
---

Run `scripts/package-skills.sh` from the repo root and report which zips were produced (or any errors). The output directory is `dist/` (gitignored). These zips are for uploading skills to Claude.ai, which does not support Claude Code plugins directly.

!`bash scripts/package-skills.sh`
