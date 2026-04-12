#!/bin/bash
# install.sh
# One-stop installation for all agents:
# 1. Deploys Claude Code skills globally (~/.claude/skills/)
# 2. Copies Junie, Windsurf, and AI Assistant project configuration to the target project

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_PROJECT="$1"

# 1. Deploy Claude Code Skills (Global)
bash "$REPO_DIR/scripts/sync-claude.sh"

# 2. Deploy Project-Specific Skills (if target project provided)
if [ -z "$TARGET_PROJECT" ]; then
  echo ""
  echo "Tip: To install Junie, Windsurf, and AI Assistant project files for a specific project, provide the path:"
  echo "  bash scripts/install.sh /path/to/your-project"
  echo ""
else
  echo "Installing project-specific skills to: $TARGET_PROJECT"
  
  if [ ! -d "$TARGET_PROJECT" ]; then
    echo "Error: Target project directory does not exist: $TARGET_PROJECT"
    exit 1
  fi

  # Copy .junie
  echo "  Copying .junie..."
  cp -r "$REPO_DIR/.junie" "$TARGET_PROJECT/"
  
  # Copy .windsurf
  echo "  Copying .windsurf..."
  cp -r "$REPO_DIR/.windsurf" "$TARGET_PROJECT/"

  # Copy .aiassistant
  echo "  Copying .aiassistant..."
  cp -r "$REPO_DIR/.aiassistant" "$TARGET_PROJECT/"

  echo ""
  echo "Done! Junie, Windsurf, and AI Assistant project files installed to $TARGET_PROJECT."
fi

echo "All agents setup complete!"
