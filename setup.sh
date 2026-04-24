#!/usr/bin/env bash
# setup.sh — scaffold a new second-brain vault from this template.
#
# Usage:
#   ./setup.sh <destination-dir> [ai-integration]
#
# Example:
#   ./setup.sh ~/my-vault claude-code
#
# If ai-integration is omitted, you'll be prompted to pick one.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEST="${1:-}"
INTEGRATION="${2:-}"

if [[ -z "$DEST" ]]; then
  read -r -p "Destination path (e.g. ~/vault): " DEST
  DEST="${DEST/#\~/$HOME}"
fi

if [[ -e "$DEST" ]]; then
  echo "Error: $DEST already exists. Pick a fresh path." >&2
  exit 1
fi

if [[ -z "$INTEGRATION" ]]; then
  echo ""
  echo "AI integration options:"
  echo "  1) claude-code  (Anthropic Claude Code CLI/IDE)"
  echo "  2) cursor       (Cursor IDE)"
  echo "  3) continue-dev (Continue.dev — open-source, any model)"
  echo "  4) opencode     (OpenCode — open-source, any model)"
  echo "  5) generic      (no auto-integration — set up your AI manually)"
  echo ""
  read -r -p "Choose (1-5) [default: 1]: " CHOICE
  case "${CHOICE:-1}" in
    1) INTEGRATION="claude-code" ;;
    2) INTEGRATION="cursor" ;;
    3) INTEGRATION="continue-dev" ;;
    4) INTEGRATION="opencode" ;;
    5) INTEGRATION="generic" ;;
    *) echo "Invalid choice" >&2; exit 1 ;;
  esac
fi

echo ""
echo "Scaffolding vault at: $DEST"
echo "AI integration:       $INTEGRATION"
echo ""

# Copy the vault skeleton
cp -R "$SCRIPT_DIR/vault/" "$DEST/"

# Ensure the new-project.sh script is executable
chmod +x "$DEST/research-skill-graph/new-project.sh" 2>/dev/null || true

# Wire up the chosen AI integration
case "$INTEGRATION" in
  claude-code)
    cp "$SCRIPT_DIR/integrations/claude-code/CLAUDE.md.example" "$DEST/CLAUDE.md"
    mkdir -p "$DEST/.claude/skills"
    cp "$SCRIPT_DIR/integrations/claude-code/skills/"*.md "$DEST/.claude/skills/"
    echo "✓ Installed Claude Code integration (CLAUDE.md + .claude/skills/braindump.md)"
    ;;
  cursor)
    cp "$SCRIPT_DIR/integrations/cursor/.cursorrules.example" "$DEST/.cursorrules"
    echo "✓ Installed Cursor integration (.cursorrules)"
    ;;
  continue-dev)
    mkdir -p "$DEST/.continue"
    echo "✓ Created .continue/ — see integrations/continue-dev/README.md for config.yaml"
    ;;
  opencode)
    cp "$SCRIPT_DIR/integrations/claude-code/CLAUDE.md.example" "$DEST/AGENTS.md"
    echo "✓ Installed OpenCode integration (AGENTS.md, adapt as needed)"
    ;;
  generic)
    echo "✓ Skipped AI wiring. See integrations/generic/README.md for patterns."
    ;;
esac

# Copy scripts (narrative generator etc.)
mkdir -p "$DEST/scripts"
cp "$SCRIPT_DIR/scripts/"*.py "$DEST/scripts/" 2>/dev/null || true

# Initialize as a fresh git repo (not connected to this template's remote)
if command -v git >/dev/null 2>&1; then
  cd "$DEST"
  git init -q
  cat > .gitignore <<'EOF'
.DS_Store
.obsidian/workspace*.json
.obsidian/cache
*.swp
node_modules/
__pycache__/
*.pyc
.venv/
venv/
EOF
  git add .
  git -c user.email="you@example.com" -c user.name="you" commit -q -m "Scaffold second-brain vault from template" || true
  echo "✓ Initialized git repo (first commit made)"
fi

echo ""
echo "Done. Next steps:"
echo ""
echo "  cd $DEST"
echo "  # Read HOME.md to understand the layout"
echo "  # Customize CLAUDE.md / .cursorrules to your preferences"
echo "  # Start your first research project:"
echo "    cd research-skill-graph && ./new-project.sh my-first-question"
echo ""
