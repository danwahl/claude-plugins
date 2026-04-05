# writing-audit

A writing editor skill that makes prose sharper, more specific, and more human. Frames everything as craft principles rather than "AI detection" to avoid priming the very patterns it flags.

Built from [humanizer](https://github.com/blader/humanizer), [avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing), [stop-slop](https://github.com/hardikpandya/stop-slop), [llm-cliches](https://github.com/nanxstats/llm-cliches), and [Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).

## Install

```
/plugin marketplace add danwahl/claude-plugins
/plugin install writing-audit@danwahl-claude-plugins
```

Then invoke: `/writing-audit:writing-audit [paste your text]`

## What it does

1. Scans text against 90+ vocabulary flags (3 tiers) and 15 structural pattern categories
2. Rewrites with all issues resolved
3. Self-checks the rewrite ("what could be sharper?") and fixes survivors

## Design choices

**Positive framing.** The skill describes craft principles to follow, not "AI slop to remove." Research on LLM instruction-following shows positive directives ("use commas and periods") outperform negative ones ("don't use em dashes"). Framing the editor as a skilled craftsperson, not a slop-cleaner, produces better rewrites.

**Parsimony.** The word table is a reference file loaded on demand, not inlined into the main prompt.

**Three-tier vocabulary.** Tier 1 (always weak), Tier 2 (weak in clusters), Tier 3 (weak by density). Reduces false positives on words that are fine alone.

**Self-audit pass.** After rewriting, the editor re-reads its own output and catches patterns that survived the first pass.

## License

MIT
