#!/bin/bash
# test-install.sh
# End-to-end verification for install.sh using a temporary HOME and target project inside the repo.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_ROOT="$REPO_DIR/.tmp/install-test"
HOME_DIR="$TEST_ROOT/home"
TARGET_PROJECT="$TEST_ROOT/target-project"
ORIGINAL_HOME="${HOME:-}"

cleanup() {
  if [ -n "$ORIGINAL_HOME" ]; then
    export HOME="$ORIGINAL_HOME"
  fi
  rm -rf "$TEST_ROOT"
}

trap cleanup EXIT

rm -rf "$TEST_ROOT"
mkdir -p "$HOME_DIR" "$TARGET_PROJECT"

export HOME="$HOME_DIR"

bash "$REPO_DIR/scripts/install.sh" "$TARGET_PROJECT"

for required_path in .junie .windsurf .aiassistant; do
  if [ ! -d "$TARGET_PROJECT/$required_path" ]; then
    echo "Missing installed directory: $required_path"
    exit 1
  fi
done

CLAUDE_SKILLS_DIR="$HOME_DIR/.claude/skills"
if [ ! -d "$CLAUDE_SKILLS_DIR" ]; then
  echo "Claude skills directory was not created."
  exit 1
fi

if ! compgen -G "$CLAUDE_SKILLS_DIR/*.md" > /dev/null; then
  echo "No Claude skills were copied during installation."
  exit 1
fi

echo "Install test passed."