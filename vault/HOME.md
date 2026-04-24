---
type: home
---

# 🧠 Second Brain

Your personal knowledge vault, structured so AI assistants can read and contribute to it.

## Sections

- **[persona/](persona/)** — who you are (loaded by every AI tool for context) ⭐ **fill this in first**
- **[people/](people/)** — colleagues, family, clients your AI should know about (optional)
- **[daily/](daily/)** — daily logs (one file per day)
- **[weekly/](weekly/)** — weekly reviews
- **[inbox/](inbox/)** — unstructured capture, process into other folders
- **[journal/](journal/)** — narrative entries (optionally AI-generated — see `scripts/narrative_generator.py`)
- **[projects/](projects/)** — one file per active project (work, side projects, research)
- **[references/](references/)** — permanent references, books, papers, docs
- **[research-skill-graph/](research-skill-graph/)** — 6-lens deep research system (see its own README)

## Daily workflow

1. Morning: create a new daily note from `_templates/daily.md`
2. Throughout the day: capture anything into `inbox/` (don't worry about structure)
3. End of day: run `/braindump` or equivalent in your AI assistant to log work to the right project file
4. End of week: create a weekly review from `_templates/weekly.md` summarizing what happened

## Philosophy — why this folder structure

See `../README.md` in the repo root for the full philosophy. In short: every AI tool you use (Claude Code, Cursor, ChatGPT, your custom assistant) needs context to be useful. This vault IS that context — a structured, machine-readable, long-lived store of your thinking that compounds over time.

## Templates

`_templates/` uses Obsidian's [Templater plugin](https://github.com/SilentVoid13/Templater) for date/title interpolation. If you're not using Obsidian, the templates are still readable markdown — just strip the `<% tp.* %>` tags and edit manually.

## Research skill graph

See `research-skill-graph/index.md` for the 6-lens methodology. Run `./new-project.sh <slug>` from that folder to scaffold a new research project.
