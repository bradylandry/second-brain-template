# FAQ

## Does this require Obsidian?

No. The vault is plain markdown. Obsidian is recommended because it handles wikilinks, folder structure, mobile apps, and templates well, but you can use VS Code, vim, iA Writer, or any editor. Nothing in the template depends on Obsidian-specific syntax except Templater tokens in `_templates/`, which are easily swapped for plain text.

## Do I need to use Claude Code?

No. There are integrations for Cursor, Continue.dev, OpenCode, Claude Projects (claude.ai web), and a generic pattern for any AI. The `/braindump` workflow translates to any tool with custom prompts or slash commands.

## Should my vault be a public repo?

**Probably not.** Your vault contains persona data, people entries, and project notes that are personal. Keep the repo private.

If you WANT part of it public (e.g., your research projects), fork this template, customize what's in `vault/`, make that public, and keep a separate private vault.

## What should I put in `.gitignore`?

The template includes sensible defaults. Pay attention to:
- `.obsidian/workspace*.json` — per-device state, will cause constant conflicts if synced
- `persona/` and `people/` — personal data, only commit to private repos
- `.env` and anything named `*secret*`, `*credentials*` — never commit secrets

## How do I handle multiple devices?

See `docs/sync.md` — the recommended pattern is iCloud (Apple devices) + git (work machines and as backup).

## The `_templates/` files have weird `<% %>` tags — what are those?

Obsidian's Templater plugin syntax. Templater is powerful (variable substitution, scripting) but not required. You can strip those tags and use plain markdown templates, OR replace with the core Daily Notes plugin's `{{date:YYYY-MM-DD}}` syntax (better mobile support).

## My AI keeps producing generic advice — how do I fix this?

99% of the time: your `persona/` files aren't populated or aren't specific enough. Open `persona/self.md`, `persona/career.md`, `persona/values.md`, `persona/collaboration.md` and actually fill them in. Vague answers produce vague advice; specific answers produce specific advice.

## How often should I run `/braindump`?

After any work session where something notable happened. 1-3 times per day is typical. Sessions that are pure maintenance or exploration with no outcomes don't need to be logged.

## How often should I update `persona/`?

Quarterly is a good rhythm. When your role, focus, or goals shift meaningfully, update `self.md` and `career.md`. `values.md` and `collaboration.md` change less often.

## Can I share my whole vault with an AI, not just pieces?

In theory yes (Claude Code with a project workspace does this automatically within its working directory). In practice, dump ALL your files into a chat and the AI's attention spreads too thin. Curate what's relevant to each conversation.

The vault structure exists specifically so AIs can grab the 5-10 relevant files and ignore the rest.

## What's the difference between `journal/` and `daily/`?

- **`daily/`** — one file per day, quick capture. Ideas, tasks, decisions, short notes. You write these.
- **`journal/`** — narrative reflection, one file per entry (usually daily). Longer-form. Optionally AI-generated (see `scripts/narrative_generator.py`) from your activity stream — git commits, chat history, calendar events.

`daily/` is lightweight shorthand. `journal/` is readable narrative you can look back on in 5 years.

## What's the difference between `references/` and `research-skill-graph/`?

- **`references/`** — static reference material. Books, articles, permanent docs you'll re-read.
- **`research-skill-graph/`** — active deep research on specific questions. Each project has a 6-lens analysis and structured outputs. Projects have a start and an end.

A finished research-skill-graph project can produce permanent references — copy the key findings into `references/`.

## How do I handle sensitive work content?

If your vault is private, add work-specific folders (`vault/work/projects/`) and rely on repo-level privacy. If your vault is public or you don't fully trust the sync chain, keep work content in a separate, internal-only vault.

Don't mix: "this is safe to publish" and "this is company-confidential" should never share a repo.

## I want to fork this and make it my own branded thing

Go for it — MIT license. Credit appreciated, not required.
