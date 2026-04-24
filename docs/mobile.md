# Mobile workflow — creating notes from your phone

The template's `_templates/` files use Obsidian's Templater plugin (`<% tp.date.now(...) %>` syntax). Templater is powerful but **clunky on mobile** — creating a new daily note on iPhone or Android requires several taps.

There's a better way.

## Use the core Daily Notes plugin for daily entries (recommended)

Obsidian ships with a core plugin called **Daily Notes** (Settings → Core plugins → Daily notes). It's simpler than Templater and works great on mobile:

### Setup (one-time, on any device)

1. Open Obsidian → Settings → Core plugins → enable **Daily notes**
2. Settings → Daily notes:
   - **Date format:** `YYYY-MM-DD` (so filenames sort correctly)
   - **New file location:** `daily`
   - **Template file location:** `_templates/daily` (no extension — Obsidian finds `.md`)

### Usage

- **Mobile:** tap the calendar icon in the sidebar → tap today's date → a new daily note appears with the template pre-filled. One tap.
- **Desktop:** same, or bind a hotkey: Settings → Hotkeys → "Daily notes: Open today's daily note" → assign `Cmd+D` (or whatever).

The template file at `_templates/daily.md` doesn't need Templater syntax — Daily Notes substitutes `{{date}}` and a few other tokens natively. But if your template uses `<% tp.date.now(...) %>` from Templater, you have two choices:

- **Keep Templater and use the "Templater: Create new note from template" command** (clunkier but mobile-capable)
- **Simplify to Daily-Notes-native syntax** (recommended — see below)

### Simplified daily template (mobile-friendly)

Replace the Templater-heavy content of `_templates/daily.md` with this:

```markdown
---
type: daily
date: {{date:YYYY-MM-DD}}
tags: [daily]
---

# {{date:YYYY-MM-DD}}

## Ideas

-

## Tasks

- [ ]

## Notes



## Decisions

-
```

`{{date:YYYY-MM-DD}}` is native Daily Notes syntax — no Templater required. Works on mobile with zero setup.

## Weekly notes on mobile — use the Periodic Notes community plugin

The core Daily Notes plugin only does daily. For weekly, install the **Periodic Notes** community plugin (Settings → Community plugins → Browse → search "Periodic Notes").

Configure:
- **Weekly notes:** enable
- **Date format:** `gggg-[W]ww` (produces filenames like `2026-W17.md`)
- **Folder:** `weekly`
- **Template:** `_templates/weekly.md`

On mobile, use the "Periodic Notes: Open this week's note" command from the command palette. Better: pin it to the mobile toolbar (Settings → Mobile → toolbar).

## Quick-capture from mobile

For throwing random thoughts into the vault without creating full daily entries, enable the **Inbox** workflow:

1. In Obsidian mobile, open Settings → Files & Links → "New link format" → leave as default
2. Create a mobile shortcut (iOS Shortcuts app or Android equivalent) that opens Obsidian with a pre-selected note at `inbox/YYYY-MM-DD-capture.md`

Or simpler: just open the inbox/ folder and tap "New file" — one-tap capture, process later.

## My actual mobile workflow

For reference, a pattern that works for many people:

1. **Morning** (desktop): tap Daily Notes → write 1-3 intentions for the day
2. **Throughout the day** (phone): drop quick ideas into inbox/ or note ideas in the daily note
3. **Evening** (desktop): process the inbox; the AI's `/braindump` absorbs any significant work into project files
4. **Friday** (desktop): create a weekly note via Periodic Notes + run `/weekly-review` (below) to summarize

Mobile is for capture. Desktop is for synthesis. Don't try to do synthesis from your phone — the friction isn't worth it.
