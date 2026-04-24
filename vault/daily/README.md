# daily/

One file per day. Filename format: `YYYY-MM-DD.md`.

**What goes here:**
- Ideas captured in the moment
- Tasks planned / completed
- Quick notes / thoughts
- Decisions made today (with reasoning)

**What does NOT go here:**
- Long-form writing → `journal/`
- Project-specific work logs → `projects/<project>.md`
- Weekly summaries → `weekly/`

Use `_templates/daily.md` as the scaffold.

## Fastest way to create these

Enable Obsidian's **core Daily Notes plugin** (Settings → Core plugins → Daily notes) and point it at:

- **Date format:** `YYYY-MM-DD`
- **New file location:** `daily`
- **Template file location:** `_templates/daily` (no extension)

Then one tap (calendar icon on mobile, `Cmd+D` on desktop) creates today's note pre-filled with your template. Works great on iPhone — see `../../docs/mobile.md` for details.

If your `_templates/daily.md` uses Templater syntax (`<% tp.date.now() %>`), swap those tokens for Daily Notes' native `{{date:YYYY-MM-DD}}` — the native tokens work on mobile without the Templater plugin.
