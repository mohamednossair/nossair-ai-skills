#!/bin/bash
# install.sh
# One-stop installation for all supported agents (Junie, AIR, Devin):
# Copies Junie, AI Assistant, and Devin project configuration to the target project.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_PROJECT="$1"

if [ -z "$TARGET_PROJECT" ]; then
  echo ""
  echo "Tip: To install Junie, AI Assistant, and Devin project files for a specific project, provide the path:"
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

  # Copy .aiassistant
  echo "  Copying .aiassistant..."
  cp -r "$REPO_DIR/.aiassistant" "$TARGET_PROJECT/"

  # Copy .devin
  echo "  Copying .devin..."
  cp -r "$REPO_DIR/.devin" "$TARGET_PROJECT/"

  echo ""
  # Copy scripts
  echo "  Copying scripts..."
  cp -r "$REPO_DIR/scripts" "$TARGET_PROJECT/"

  echo ""
  echo "Done! Junie, AI Assistant, Devin project files, and prerequisite scripts installed to $TARGET_PROJECT."
fi

echo "All supported agents setup complete!"
