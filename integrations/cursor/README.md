# Cursor integration

[Cursor](https://cursor.com) is an AI-first fork of VSCode that reads project-level rules from `.cursorrules`.

## Setup

```bash
cp integrations/cursor/.cursorrules.example vault/.cursorrules
```

Open your vault in Cursor. The rules load automatically; AI edits in that workspace will respect them.

## Braindump equivalent

Cursor doesn't have first-class slash commands the way Claude Code does. The equivalent is either:

1. **Chat command:** type "braindump: <your session summary>" in Cursor's chat — the rules file instructs the model to handle this pattern.
2. **Composer macro:** use Cursor's Composer feature with a saved prompt that matches the `/braindump` behavior described in the rules file.

Cursor improves rapidly; by the time you read this, native slash commands may exist. Check the docs.

## What's missing vs Claude Code

- No equivalent of `.claude/skills/` — can't define reusable commands as separate files
- No persistent cross-session memory layer
- Less structured around agent behavior; more around autocomplete

Still a valid choice if you already use Cursor. The `.cursorrules` file carries ~80% of the context of a full `CLAUDE.md` setup.
