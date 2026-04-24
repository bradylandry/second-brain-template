# weekly/

One file per week. Filename format: `YYYY-WNN.md` (ISO week, e.g. `2026-W17.md`).

**What goes here:**
- High-level summary of the week
- Wins, setbacks, blockers
- Priorities for next week
- Reflection on commitments made vs kept

Friday afternoon or Sunday evening is a good rhythm. Use `_templates/weekly.md`.

## How to generate these (two options)

### Option 1 — AI-assisted (recommended)

Use the `/weekly-review` skill in Claude Code (or equivalent in your AI tool). It reads the week's daily notes + project file updates, drafts a synthesized weekly note, and lets you review before committing.

```
> /weekly-review
```

The AI reads `daily/*.md` files from the past 7 days, any dated sections in `projects/*.md` added this week, and the git log. Produces a draft covering highlights, decisions, blockers, next-week priorities, and reflection. You edit to taste, commit.

This is the intended workflow — manual weekly notes rarely get written consistently because synthesis is hard. Having the AI do the first-pass synthesis removes the friction.

### Option 2 — Manual

Open `_templates/weekly.md` in your editor, copy to `weekly/YYYY-WNN.md`, fill in by hand.

### Option 3 — Periodic Notes plugin (for mobile users)

Install the **Periodic Notes** community plugin in Obsidian. Set:
- **Weekly notes format:** `gggg-[W]ww`
- **Weekly notes folder:** `weekly`
- **Template:** `_templates/weekly`

Now on mobile, the "Periodic Notes: Open this week's note" command creates the file with your template. You or your AI fill it in from there.

## What makes a weekly note good

- **Synthesis over compilation.** Don't list everything that happened. Surface the 3-5 things that mattered.
- **Honest over cheerleading.** If you didn't hit your intentions, say so. Pretending otherwise breaks the long-term usefulness of the vault.
- **Decisions > activities.** "Moved 100 units" is less useful than "decided to focus on X because Y." Future you will grep for why you made decisions.
- **Length cap: 400-600 words.** More than that rarely gets re-read.
