#!/bin/bash
# sync-claude.sh
# Deploys skills from .claude/skills/ to ~/.claude/skills/ (global Claude Code slash commands)
# Run this whenever you add or update skills in .claude/skills/

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_DIR/.claude/skills"
if [ -n "$USERPROFILE" ]; then
  DEST_DIR="$USERPROFILE/.claude/skills"
else
  DEST_DIR="$HOME/.claude/skills"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

mkdir -p "$DEST_DIR"

echo "Syncing Claude Code skills..."
echo "  From: $SOURCE_DIR"
echo "  To:   $DEST_DIR"
echo ""

COUNT=0
for file in "$SOURCE_DIR"/*.md; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")
  cp "$file" "$DEST_DIR/$filename"
  skill_name="${filename%.md}"
  echo "  ✓ /$skill_name"
  COUNT=$((COUNT + 1))
done

echo ""
echo "Done! Synced $COUNT skill(s) to Claude Code."
echo "Use them in Claude Code with: /java-review, /spring-api, /ts-review, etc."
echo ""
echo "--- Junie & Windsurf ---"
echo "These are project-specific. Copy to each project as needed:"
echo ""
echo "  Junie:"
echo "    cp -r '$REPO_DIR/.junie' /your-project/"
echo ""
echo "  Windsurf:"
echo "    cp -r '$REPO_DIR/.windsurf' /your-project/"
echo ""
