# Claude Code integration

[Claude Code](https://claude.com/claude-code) is Anthropic's CLI / IDE extension for coding with Claude. It picks up configuration from two files in your project root:

- `CLAUDE.md` — house rules, style preferences, context
- `.claude/skills/*.md` — custom slash commands

## Setup

From the repo root:

```bash
# 1. Copy CLAUDE.md to your vault root
cp integrations/claude-code/CLAUDE.md.example vault/CLAUDE.md

# 2. Copy the slash commands into your vault
mkdir -p vault/.claude/commands
cp integrations/claude-code/skills/braindump.md   vault/.claude/commands/braindump.md
cp integrations/claude-code/skills/onboard-vault.md vault/.claude/commands/onboard-vault.md
cp integrations/claude-code/skills/challenge.md    vault/.claude/commands/challenge.md
cp integrations/claude-code/skills/emerge.md       vault/.claude/commands/emerge.md
cp integrations/claude-code/skills/weekly-review.md vault/.claude/commands/weekly-review.md
```

> **Path note:** Claude Code looks for slash commands in `.claude/commands/`, not `.claude/skills/`. The source files live in `integrations/claude-code/skills/` for organizational reasons (they're more like "skills" semantically than commands), but they need to be copied into `.claude/commands/` to work as slash commands.

To make any of these globally available across all projects, symlink into `~/.claude/commands/`:

```bash
ln -s "$(pwd)/vault/.claude/commands/challenge.md" ~/.claude/commands/challenge.md
```

Open your vault in Claude Code (`cd vault && claude` or open in VSCode with the Claude Code extension). The `CLAUDE.md` loads automatically, and the slash commands are available.

## What you get

- **Contextual editing:** Claude reads your vault structure, matches tone of existing files, and respects your section conventions.
- **`/braindump`:** dump a session summary, the skill finds the right project file, adds a dated section, and commits.
- **`/onboard-vault`:** populate persona and project files from existing context — runs once on a fresh vault.
- **`/challenge`:** pressure-test a current decision against your stated values, decision-patterns, and recent project history. Names contradictions with verbatim citations.
- **`/emerge`:** surface 3-5 unnamed recurring patterns across your project files. Helps name patterns you keep hitting but haven't formalized.
- **`/weekly-review`:** draft this week's review from daily notes and project updates.
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
