# Device Sync — keeping your vault on every device you use

Your vault lives on your computer. You probably also want it on your phone, your personal laptop, your work laptop, and maybe your tablet. Figuring out sync early saves you from accidentally diverging copies later.

Five patterns, ranked by how often I see them work in practice.

## 1. Hybrid iCloud + git (recommended for Apple-heavy users)

**Best if:** you have a mix of Apple devices (Mac + iPhone + iPad) AND a work machine that can't use iCloud (corporate policy, or Windows, or Linux).

**Setup:**

- **Primary Mac** — Obsidian vault lives in the default Obsidian iCloud directory:
  ```
  ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/my-vault/
  ```
  iCloud syncs it to your iPhone and iPad automatically. Inside that folder, run `git init` and push to GitHub (or Bitbucket, GitLab — whatever private remote you prefer).

- **iPhone / iPad** — install Obsidian mobile. It picks up the vault from iCloud automatically with default settings. Read-mostly on phone, edit on iPad with a keyboard if needed.

- **Work laptop** — clone the vault from GitHub into a normal directory (NOT iCloud — most corporate policies block iCloud). Work there; push/pull as you would any repo.

**Why this works:**
- Apple devices get instant sync via iCloud (no manual pull on the phone)
- Work machine stays on git, independent of iCloud
- GitHub is your durable backup — if iCloud corrupts (rare but happens), you lose nothing
- Free (uses existing iCloud + GitHub)

**Gotchas:**
- Obsidian on iOS occasionally creates `.trash/` folders with old versions. Add to `.gitignore`.
- If both Macs edit the same file at the same time, iCloud handles merge; git will too. Conflicts rare but do happen — commit often.
- Don't commit `.obsidian/workspace.json` (per-device state). Already in the template's `.gitignore`.

## 2. Git-only on all devices

**Best if:** you're disciplined about pulling before editing and pushing after, and don't need instant mobile sync.

**Setup:**
- Clone the vault on every device to a normal folder
- Edit in Obsidian (or any markdown editor)
- Pull before session, commit after, push when done

**Why it's appealing:** no dependency on iCloud / third-party sync. Pure git.

**Why it fails for most people:** on iOS, git clients are clunky. Unless you're willing to open Working Copy (or similar) before every phone edit, you'll drift. Desktops are fine.

## 3. Obsidian Sync (paid, $4/mo)

Obsidian's own sync service. Works on every device Obsidian runs on. End-to-end encrypted. No git required.

**Best if:** you don't want to think about git or iCloud and $4/month is nothing to you. Also the cleanest experience on non-Apple mobile (Android).

**Tradeoff:** you lose git history. Version control is Obsidian's own timeline feature, which is fine for "oops I deleted that" but lacks the diff/commit/branch power git gives you. Many users pair Obsidian Sync with a weekly git backup job.

## 4. Syncthing (free, peer-to-peer)

Open-source file sync across devices. No cloud provider in the middle.

**Best if:** you're privacy-focused and don't want anything in a third-party cloud.

**Tradeoff:** setup is fiddlier than iCloud. Requires Syncthing running on every device (doable on iOS via third-party apps but clunkier). Your devices need to be online at overlapping times for sync to work without a relay server.

## 5. Dropbox / Google Drive / OneDrive

Technically works. Not recommended — these sync every file change as an individual event, which fights with Obsidian's own cache and plugin files. You'll see phantom conflict files regularly.

Use if it's the only option at your workplace. Otherwise pick another pattern.

---

## My recommendation

For most people who have a Mac + iPhone and a work computer:

**Pattern 1 (iCloud + git).** Zero cost, zero ongoing maintenance, works with every editor on every platform, and you get both Apple's instant sync AND git's durable backup. Best of both.

## Relevant `.gitignore` entries

The template's `.gitignore` already excludes these, but if you're setting up manually:

```
# Obsidian workspace state (per-device)
.obsidian/workspace*.json
.obsidian/cache

# iOS Obsidian occasionally creates these
.trash/

# macOS metadata
.DS_Store

# Personal data — you probably don't want these public
persona/
people/

# Anything you explicitly want out
private/
```

Customize based on your privacy preferences — if your repo is private, you may want to keep `persona/` and `people/` in the repo (they're more useful to your AI when available).
