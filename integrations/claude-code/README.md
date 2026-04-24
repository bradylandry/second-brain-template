# Claude Code integration

[Claude Code](https://claude.com/claude-code) is Anthropic's CLI / IDE extension for coding with Claude. It picks up configuration from two files in your project root:

- `CLAUDE.md` — house rules, style preferences, context
- `.claude/skills/*.md` — custom slash commands

## Setup

From the repo root:

```bash
# 1. Copy CLAUDE.md to your vault root
cp integrations/claude-code/CLAUDE.md.example vault/CLAUDE.md

# 2. Copy the /braindump skill
mkdir -p vault/.claude/skills
cp integrations/claude-code/skills/braindump.md vault/.claude/skills/braindump.md
```

Open your vault in Claude Code (`cd vault && claude` or open in VSCode with the Claude Code extension). The `CLAUDE.md` loads automatically, and `/braindump` is available as a slash command.

## What you get

- **Contextual editing:** Claude reads your vault structure, matches tone of existing files, and respects your section conventions.
- **`/braindump` skill:** dump a session summary, the skill finds the right project file, adds a dated section, and commits.
- **House rules enforced:** no paraphrased summaries, no frontmatter reorders, no pushing without approval.

## Extending

Add your own skills:

```bash
# .claude/skills/weekly-review.md
---
name: weekly-review
description: Draft this week's review from daily notes and project updates.
---
... your prompt ...
```

Skills are just markdown files with a specific frontmatter. Claude Code picks them up automatically and they become `/weekly-review` in your session.

## What makes this integration special

Claude Code's strength for a vault workflow is the **persistent memory layer**. As of Claude 4.x, it maintains an auto-memory of facts, preferences, and patterns across conversations in the same project. Your vault becomes the working context, auto-memory becomes the long-term pattern recognition. The two layers reinforce each other.
