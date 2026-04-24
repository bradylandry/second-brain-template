#!/usr/bin/env python3
"""
narrative_generator.py — generate a dated markdown journal entry from your
day's activity across multiple sources.

This is a REFERENCE IMPLEMENTATION. Adapt it to your own data sources.

Inputs (optional — wire up whichever you have):
- git commits today across your active repos
- chat history with your AI assistant
- calendar events from today
- daily note from vault/daily/YYYY-MM-DD.md
- manually piped summary via stdin

Output:
- vault/journal/YYYY-MM-DD.md — a narrative summary of the day
- Optionally committed to git

Usage:
    python narrative_generator.py [--dry-run] [--date YYYY-MM-DD]

Requirements:
    pip install anthropic  (or openai / google-generativeai — swap the client)
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from datetime import date as date_mod, datetime
from pathlib import Path

VAULT = Path(os.environ.get("VAULT_PATH", Path.home() / "vault"))
JOURNAL_DIR = VAULT / "journal"
DAILY_DIR = VAULT / "daily"

# List of git repos to scan for today's commits. Customize for your setup.
REPOS_TO_SCAN: list[Path] = [
    # Path.home() / "code" / "my-project",
    # Path.home() / "code" / "another-project",
]


def today_iso(override: str | None = None) -> str:
    if override:
        return override
    return date_mod.today().strftime("%Y-%m-%d")


def collect_git_activity(day: str) -> str:
    """Return a summary of commits across REPOS_TO_SCAN made on `day`."""
    lines: list[str] = []
    for repo in REPOS_TO_SCAN:
        if not repo.exists():
            continue
        try:
            out = subprocess.run(
                ["git", "-C", str(repo), "log",
                 f"--since={day} 00:00", f"--until={day} 23:59",
                 "--pretty=format:%s", "--author=$(git config user.email)"],
                capture_output=True, text=True, check=False, timeout=10,
            )
            commits = [line for line in out.stdout.strip().splitlines() if line]
            if commits:
                lines.append(f"### {repo.name}")
                lines.extend(f"- {c}" for c in commits)
                lines.append("")
        except Exception as e:
            lines.append(f"### {repo.name} — scan failed: {e}")
    return "\n".join(lines) or "(no git activity)"


def read_daily_note(day: str) -> str:
    p = DAILY_DIR / f"{day}.md"
    if p.exists():
        return p.read_text()
    return "(no daily note)"


def read_stdin_if_piped() -> str:
    """Return stdin contents if something was piped in, otherwise empty string."""
    if sys.stdin.isatty():
        return ""
    return sys.stdin.read().strip()


def llm_narrate(context: str, day: str) -> str:
    """Call the LLM to turn structured context into a narrative entry."""
    prompt = f"""You are writing a dated journal entry for {day}.

You have access to multiple signals of what the user did today. Weave them into
a single concise narrative (300-600 words max) that reads like a personal
journal — first person, reflective, not a bullet list.

Focus on:
- What was actually accomplished (concrete, not aspirational)
- Decisions made and the reasoning behind them
- Blockers or surprises worth remembering
- Threads that carry into tomorrow

Avoid:
- Rote "I did X, then Y, then Z" structure
- Marketing language / achievements puffery
- Generic reflection ("it was a productive day")
- Making up events not in the context

Here is the context:

{context}

Write the entry. Start with today's date as a heading. No preamble."""

    # Swap this block for whichever client you prefer.
    try:
        import anthropic
    except ImportError:
        print("Install with: pip install anthropic", file=sys.stderr)
        sys.exit(1)

    client = anthropic.Anthropic()  # reads ANTHROPIC_API_KEY from env
    result = client.messages.create(
        model=os.environ.get("NARRATIVE_MODEL", "claude-sonnet-4-5"),
        max_tokens=2000,
        messages=[{"role": "user", "content": prompt}],
    )
    return result.content[0].text.strip()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true", help="Print, don't write")
    parser.add_argument("--date", help="YYYY-MM-DD, defaults to today")
    args = parser.parse_args()

    day = today_iso(args.date)
    JOURNAL_DIR.mkdir(parents=True, exist_ok=True)

    # Collect context from your sources. Customize freely.
    parts = []
    git = collect_git_activity(day)
    if git:
        parts.append(f"## Git activity\n{git}")
    daily = read_daily_note(day)
    if daily:
        parts.append(f"## Daily note\n{daily}")
    piped = read_stdin_if_piped()
    if piped:
        parts.append(f"## Piped summary\n{piped}")

    if not parts:
        print(f"No activity sources produced content for {day}. Exiting.", file=sys.stderr)
        sys.exit(1)

    context = "\n\n".join(parts)
    narrative = llm_narrate(context, day)

    out_path = JOURNAL_DIR / f"{day}.md"
    body = (
        f"---\ntype: journal\ndate: {day}\ngenerated: true\n---\n\n"
        f"{narrative}\n"
    )

    if args.dry_run:
        print(body)
        return

    out_path.write_text(body)
    print(f"Wrote {out_path}")


if __name__ == "__main__":
    main()
