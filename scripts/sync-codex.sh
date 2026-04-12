#!/bin/bash
# sync-codex.sh
# Deploys skills from .junie/skills/ to $CODEX_HOME/skills/ (global Codex skills)

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_DIR/.junie/skills"

if [ -n "$CODEX_HOME" ]; then
  DEST_ROOT="$CODEX_HOME"
elif [ -n "$HOME" ]; then
  DEST_ROOT="$HOME/.codex"
else
  DEST_ROOT="$USERPROFILE/.codex"
fi

DEST_DIR="$DEST_ROOT/skills"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

mkdir -p "$DEST_DIR"

echo "Syncing Codex skills..."
echo "  From: $SOURCE_DIR"
echo "  To:   $DEST_DIR"
echo ""

COUNT=0
for skill_dir in "$SOURCE_DIR"/*; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  rm -rf "$DEST_DIR/$skill_name"
  cp -r "$skill_dir" "$DEST_DIR/"
  echo "  - $skill_name"
  COUNT=$((COUNT + 1))
done

echo ""
echo "Done! Synced $COUNT skill(s) to Codex."
echo "Restart Codex to pick up new skills."
echo ""
