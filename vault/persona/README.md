# persona/

**This is the most important folder in the vault for AI integration.**

Every AI tool you use is a stateless stranger every time you start a conversation. This folder tells the AI who you are: your role, expertise, goals, communication preferences. It's the difference between "give me 5 generic career tips" and "here's advice that actually applies to someone in your specific situation."

## Files

- **`self.md`** — the master "who I am" file. Your AI's starting point.
- **`career.md`** — career exec summary: past roles, accomplishments, trajectory
- **`values.md`** — how you make decisions, what you optimize for, what you won't compromise
- **`collaboration.md`** — how you want the AI to work with you (tone, verbosity, when to push back)

## How to use

Each file below is a **template** with prompts and example content. Your job:

1. Read the prompts
2. Replace them with your actual answers
3. Keep files under ~500 words each (AI context windows aren't infinite; density matters)
4. Update quarterly — your role/goals/values shift and the files should reflect that

## How your AI uses these

Every integration in this repo (Claude Code, Cursor, Claude Projects, etc.) instructs the AI to load `persona/self.md` at the start of a conversation. Additional files get pulled in when relevant (`career.md` when discussing career decisions, etc.).

You can also explicitly paste `persona/self.md` at the top of any new chat with an AI that doesn't have auto-loading — it's markdown, readable by anything.

## Privacy

This folder contains personal information. If you sync your vault to a public git repo, **add `persona/` to `.gitignore`**. The template already does this; verify your setup.
