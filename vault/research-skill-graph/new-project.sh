#!/usr/bin/env bash
# Scaffold a new research project in research-skill-graph/projects/<slug>/
# Usage: ./new-project.sh [slug]
# If slug is omitted, you'll be prompted for it.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECTS_DIR="$ROOT/projects"
TODAY="$(date +%Y-%m-%d)"

prompt() {
  local var_name="$1" label="$2" default="${3:-}"
  local value
  if [[ -n "$default" ]]; then
    read -r -p "$label [$default]: " value
    value="${value:-$default}"
  else
    read -r -p "$label: " value
  fi
  printf -v "$var_name" '%s' "$value"
}

multiline_prompt() {
  local var_name="$1" label="$2"
  echo "$label (end with a blank line):"
  local lines=()
  while IFS= read -r line; do
    [[ -z "$line" ]] && break
    lines+=("$line")
  done
  local joined
  joined="$(printf '%s\n' "${lines[@]}")"
  printf -v "$var_name" '%s' "$joined"
}

slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g'
}

SLUG="${1:-}"
if [[ -z "$SLUG" ]]; then
  prompt SLUG "Project slug (kebab-case, e.g. career-positioning-2026)"
fi
SLUG="$(slugify "$SLUG")"

if [[ -z "$SLUG" ]]; then
  echo "Error: slug cannot be empty" >&2
  exit 1
fi

PROJECT_DIR="$PROJECTS_DIR/$SLUG"
if [[ -e "$PROJECT_DIR" ]]; then
  echo "Error: $PROJECT_DIR already exists" >&2
  exit 1
fi

echo ""
echo "=== New Research Project: $SLUG ==="
echo ""

prompt TITLE "Display title" "$(echo "$SLUG" | sed -E 's/-/ /g' | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) substr($i,2)} 1')"
prompt QUESTION "Research question (one sentence)"
prompt SCOPE_IN "Scope — IN (comma-separated)"
prompt SCOPE_OUT "Scope — OUT (comma-separated)"
prompt TIME_HORIZON "Time horizon (e.g. 'Current + 5-year outlook')"
prompt OUTPUT_GOAL "Output goal (what decision does this inform?)"
prompt PRIOR "Prior research (leave blank if none)" "No prior context — starting fresh."
multiline_prompt CONTEXT "Quick context (blank line to finish)"

mkdir -p "$PROJECT_DIR"

cat > "$PROJECT_DIR/index.md" <<EOF
---
type: research-project
created: $TODAY
---

# $TITLE

## Research Question
$QUESTION

## Scope
- **In:** $SCOPE_IN
- **Out:** $SCOPE_OUT
- **Time Horizon:** $TIME_HORIZON
- **Output Goal:** $OUTPUT_GOAL

## Prior Research
$PRIOR

---

## Execution Checklist

- [ ] [[../../lenses/technical]] — what do the numbers say?
- [ ] [[../../lenses/economic]] — follow the money and incentives
- [ ] [[../../lenses/historical]] — what patterns and precedents apply?
- [ ] [[../../lenses/geopolitical]] — which power dynamics shape this?
- [ ] [[../../lenses/contrarian]] — stress-test every assumption
- [ ] [[../../lenses/first-principles]] — rebuild from fundamental truths
- [ ] Synthesis — [[executive-summary]], [[deep-dive]], [[key-players]], [[open-questions]]

---

## Outputs

*Generated after research completes*

- [[executive-summary]]
- [[deep-dive]]
- [[key-players]]
- [[open-questions]]

---

## Quick Context

$CONTEXT
EOF

for name in executive-summary deep-dive key-players open-questions; do
  cat > "$PROJECT_DIR/$name.md" <<EOF
---
type: research-output
date: $TODAY
---

# ${name//-/ } — $TITLE

*Generated after research completes.*
EOF
done

ROOT_INDEX="$ROOT/index.md"
if [[ -f "$ROOT_INDEX" ]] && grep -q "^## 4\. Active Projects" "$ROOT_INDEX"; then
  ENTRY="- [[projects/$SLUG/index]] — $TITLE: $QUESTION"
  if ! grep -qF "projects/$SLUG/index" "$ROOT_INDEX"; then
    awk -v entry="$ENTRY" '
      /^## 4\. Active Projects/ {
        print
        if ((getline nextline) > 0) print nextline
        print entry
        next
      }
      { print }
    ' "$ROOT_INDEX" > "$ROOT_INDEX.tmp" && mv "$ROOT_INDEX.tmp" "$ROOT_INDEX"
  fi
fi

echo ""
echo "Created: $PROJECT_DIR"
echo ""
ls -1 "$PROJECT_DIR"
echo ""
echo "Next: open $PROJECT_DIR/index.md and run your research agent against it."
