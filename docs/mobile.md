# Mobile workflow — creating notes from your phone

The template's `_templates/` files use Obsidian's Templater plugin (`<% tp.date.now(...) %>` syntax). Templater is powerful but **clunky on mobile** — creating a new daily note on iPhone or Android requires several taps.

There's a better way.

## Setting up iCloud sync between iPhone and Mac (Apple users)

**Install Obsidian on the iPhone first**, not the Mac. Counterintuitive, but it's the path of least resistance — iOS Obsidian has a "Store in iCloud" toggle that creates the right container path; Mac Obsidian doesn't, so going Mac-first means manually creating folders in the iCloud Drive container.

### iPhone-first flow (recommended)

1. **Install Obsidian** from the App Store on your iPhone.
2. Open Obsidian → **Create new vault**:
   - **Vault name:** match what you'll use on Mac (e.g. `my-vault`).
   - Toggle **"Store in iCloud"** ON. This is the critical step.
3. iOS creates the vault at `iCloud Drive → Obsidian → my-vault`. iCloud syncs the empty folder up.
4. **On Mac**, install Obsidian (desktop). When it opens:
   - Click **"Open"** (not "Create new").
   - Navigate to `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault` — that's where iOS Obsidian put your iCloud vault.
   - Open it. Mac Obsidian now opens the same vault that's syncing to your phone.
5. **Drop the template contents into the iCloud-synced vault.** Two ways:

   **Best for new users** — when you run `setup.sh`, point it at the iCloud path:

   ```bash
   ./setup.sh "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault"
   ```

   `setup.sh` will populate the iCloud-synced folder with the template structure, and iCloud will push it to your phone within seconds.

   **If you already ran `setup.sh ~/my-vault`** — move the contents into the iCloud folder:

   ```bash
   mv ~/my-vault/* ~/my-vault/.* "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault/" 2>/dev/null
   rmdir ~/my-vault
   ```

### Mac-first flow (also works, slightly more work)

1. Install Obsidian on Mac. Don't open it yet.
2. Create the iCloud Obsidian container manually (it doesn't exist until something writes there):

   ```bash
   mkdir -p "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault"
   ```

3. Run `./setup.sh "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault"` to populate it.
4. Open Obsidian on Mac → **"Open"** → navigate to the iCloud path → open the vault.
5. Wait 30-60 seconds for iCloud to push the folder up.
6. Install Obsidian on iPhone → it should detect the existing iCloud vault automatically and offer to open it.

### "I already created a vault outside iCloud — do I need to start over?"

No. Don't uninstall Obsidian. Just move the vault folder into the iCloud Obsidian container — your existing notes come along for the ride.

```bash
# Replace `my-vault` with your actual vault name + adjust the source path
SOURCE="$HOME/my-vault"   # or wherever your existing vault is
DEST="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault"

mkdir -p "$DEST"
mv "$SOURCE"/* "$SOURCE"/.* "$DEST/" 2>/dev/null
rmdir "$SOURCE"
```

The `$SOURCE/.*` glob captures dotfiles — `.git`, `.obsidian`, `.gitignore` — which you definitely want to keep. The `2>/dev/null` suppresses the harmless warning about `.` and `..` not being movable.

Then in Obsidian on your Mac:

1. **File → Open vault** (or close the current vault and pick a new one)
2. Navigate to the iCloud path (`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault`)
3. Open it. Obsidian indexes it as a fresh open; nothing else changes.
4. (Optional) Right-click the old vault location in Obsidian's vault switcher → **Remove from list**. This only removes the bookmark; the empty folder is already gone from `rmdir`.

**Common gotchas after the move:**

- **Symlinks break.** If you had any `ln -s` links into the vault from elsewhere, they now point at empty dirs. Re-create them at the new path.
- **Templater scripts with hardcoded paths break.** If any custom Templater code references `~/my-vault/...` as a string, update it to the new iCloud path.
- **Cron jobs break.** If `weekly_rollup.py` (or similar) references the old `OBSIDIAN_VAULT_DIR`, update the env var or the script's default.
- **First sync is slow.** iCloud has to upload the full vault. Expect 5-30 minutes for a vault with images/PDFs; pure-text vaults sync in seconds.

After the move, install Obsidian on your iPhone → it'll detect the existing iCloud vault automatically and offer to open it. No manual import.

### Critical caveats

- **iCloud sync is not git.** It's eventual-consistency file sync. If you edit the same file on both devices simultaneously, you'll get a conflict copy. For a personal vault used by one person across two devices, that's almost never an issue. For collaborative or high-write workloads, prefer git sync (see below).
- **The `.git` directory syncs over iCloud too.** This is fine but slow on first sync. If you don't want git pushing/pulling from your phone, do `.gitignore` style filtering or just don't commit from phone.
- **Don't put your vault in `iCloud Drive → Documents`** (the generic Documents folder). The Obsidian-specific path (`iCloud~md~obsidian/Documents/`) is what iOS Obsidian indexes — putting the vault elsewhere in iCloud means Obsidian on iPhone can't find it without manual import.

### Git sync as an alternative or addition

For a vault you're already pushing to GitHub (like the one `setup.sh` creates), you have a choice:

- **Use iCloud only** — simplest. Vault lives in the iCloud Obsidian container; iCloud syncs Mac ↔ iPhone. Push to git from your Mac when you want a backup or to share with another machine.
- **Use git only** — install [Working Copy](https://workingcopyapp.com/) on iPhone (~$20). Clone your vault repo into Working Copy → open from Obsidian iOS via Files app integration. No iCloud involvement. Better conflict handling, but more friction (manual pull/push on phone).
- **Use both** — iCloud for fast realtime sync, git for backup + history. Most reliable but the double-tracking can produce confusing situations.

For a personal one-person vault, **iCloud-only is usually right** until you hit a sync issue. Then add git.

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
