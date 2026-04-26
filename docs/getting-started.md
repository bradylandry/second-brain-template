# Getting Started

A 15-minute walkthrough to go from zero to your first AI-assisted vault session.

## Step 1 — Scaffold your vault (1 minute)

```bash
git clone git@github.com:bradylandry/second-brain-template.git
cd second-brain-template
./setup.sh ~/my-vault
```

Choose your AI integration when prompted. If unsure, pick Claude Code — it has the tightest integration and the most developed patterns.

You now have `~/my-vault/` containing everything you need.

### Important: the template ≠ your vault

The cloned `second-brain-template/` directory is a **one-time installer**. `setup.sh` did three things:

1. Copied the vault skeleton (folders + templates + persona stubs + README files) to `~/my-vault/`
2. Wired the AI integration files you picked (e.g. `CLAUDE.md`)
3. **Initialized a fresh git repo at `~/my-vault/`** — completely separate from the template's git history

**Your vault is `~/my-vault/`** (or whatever destination path you chose). That's the directory you work in from now on. You can:

- **Delete the cloned `second-brain-template/` directory** — its job is done.
- **Or keep it** as a reference for re-running setup or pulling future template updates manually. But don't work inside it — your personal content would mix with template files, and `git pull` from the template would conflict with your edits.

The rest of this guide refers to `~/my-vault/` paths. Run all commands from inside `~/my-vault/`, not inside the cloned template.

## Step 2 — Fill in your persona (10 minutes — DO NOT SKIP)

Open these files and replace the placeholder prompts with your actual answers:

- `~/my-vault/persona/self.md` — who you are
- `~/my-vault/persona/career.md` — career arc
- `~/my-vault/persona/values.md` — how you make decisions
- `~/my-vault/persona/collaboration.md` — how AIs should work with you

**This is the highest-ROI 10 minutes you can spend.** A vault without populated persona files gives the AI nothing to ground on — you'll get generic advice every time. A vault with well-written persona files produces surprisingly specific, relevant help on the first try.

### Don't want to fill four empty files by hand?

You don't have to. Two ways to get an AI to interview you and write the persona files (and project files) for you:

**Path A — Claude Code (or any agent with file-write tools): zero copy-paste.**

Open Claude Code in your vault directory and invoke the `/onboard-vault` skill (defined in `integrations/claude-code/skills/onboard-vault.md`). Claude interviews you and writes each file directly to the right path in your vault. You answer questions; Claude does the file editing. This is the cleanest experience.

The same pattern works in any agent with file-edit tool access (Cursor, Aider, Cline, etc.) — you can paste the prompt from `docs/onboarding-prompt.md` and the agent will write files directly instead of just outputting text.

**Path B — Web LLMs (ChatGPT, Gemini, Claude.ai web): copy-paste flow.**

If you're using a web LLM that can only output text (not edit files), paste the prompt from [`docs/onboarding-prompt.md`](onboarding-prompt.md) into a fresh chat. The LLM interviews you and outputs each file as markdown in a code block. You copy-paste each block into the matching path in your vault.

Either path takes ~15-25 minutes if you do persona + projects in one session. You can stop and resume any time.

Rules of thumb:
- Be honest, not aspirational (an AI advising "you" needs to see real you)
- Be specific, not generic ("I run a 21-strategy quant system" > "I do trading")
- Keep each file under ~500 words (AI context windows aren't infinite)
- Update quarterly as your role/goals shift

## Step 3 — Push to a private git remote (2 minutes)

Your vault includes personal data. Host it privately.

```bash
cd ~/my-vault
# Create an empty private repo on GitHub (or Bitbucket, GitLab — whatever)
# Then:
git remote add origin git@github.com:YOU/my-vault.git
git push -u origin main
```

Git is your durable backup. If your laptop dies, you still have everything.

## Step 4 — Open in your AI tool (1 minute)

### If you picked Claude Code:

```bash
cd ~/my-vault
claude
```

Claude Code auto-loads `CLAUDE.md` and the skills in `.claude/skills/`. Try:

```
> /braindump
>
> Worked on the XYZ project today. Fixed the race condition in the
> payment webhook handler, added a test, deployed to staging. Still
> need to test the refund flow before production.
```

Claude will identify the right project file (or ask which if it's ambiguous), add a dated section in the file's style, and suggest a commit.

### If you picked Cursor:

Open `~/my-vault` as the Cursor workspace. `.cursorrules` loads automatically. Start a chat and ask:

```
Log this to my second brain: [your session summary]
```

### If you picked something else:

See `integrations/<your-tool>/README.md` for specifics.

## Step 5 — Start your first project file (5 minutes)

Create `~/my-vault/projects/my-first-project.md` using `_templates/project.md` as the starting structure:

```bash
cp ~/my-vault/_templates/project.md ~/my-vault/projects/my-first-project.md
# Edit to describe a real project you're actively working on
```

Now your AI has:
- A persona it's grounded on (step 2)
- A project it's working with you on (this step)
- A vault it can write back to (all of it)

Next time you do real work on that project, type `/braindump` (or equivalent) and the AI will maintain the project file for you.

## Step 6 — Optional: start a research project (5 minutes)

```bash
cd ~/my-vault/research-skill-graph
./new-project.sh my-research-question
# Answers: question, scope (in/out), time horizon, output goal
```

A populated project folder appears with stubs for the 4 outputs (executive-summary, deep-dive, key-players, open-questions).

Point your AI at the index.md and say:

```
Read research-skill-graph/projects/my-research-question/index.md,
then the methodology and lens files. Execute all 6 lenses against
this question and write the output files.
```

For a serious research task, this produces a multi-angle analysis no single ChatGPT prompt can match.

## What good looks like at day 7

After a week of use, you should see:

- Each project you work on has a file with 2-3 dated sections
- Your inbox is empty (you processed items into projects or deleted them)
- Your persona files feel accurate (you've edited them once or twice as you noticed gaps)
- You've used `/braindump` 5-10 times and the pattern has become habitual
- You've committed to git every day or two

If any of those aren't happening, your friction is probably in the vault structure or the AI wiring. Check `docs/faq.md` for common issues.

## What good looks like at day 90

- Your project files are the real documentation of what you've been working on
- When you start a new conversation with any AI, you paste in the relevant project + persona files and get help that actually fits your context
- You have 3-5 completed research projects from `research-skill-graph/`
- The daily journal (if you enabled it) gives you a readable narrative of your last 3 months
- You realize your AI conversations have gotten dramatically better — not because the models got better, but because the context you're grounding them on has compounded
