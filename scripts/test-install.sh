#!/bin/bash
# test-install.sh
# End-to-end verification for install.sh using a temporary target project inside the repo.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_ROOT="$REPO_DIR/.tmp/install-test"
TARGET_PROJECT="$TEST_ROOT/target-project"

cleanup() {
  rm -rf "$TEST_ROOT"
}

trap cleanup EXIT

rm -rf "$TEST_ROOT"
mkdir -p "$TARGET_PROJECT"

bash "$REPO_DIR/scripts/install.sh" "$TARGET_PROJECT"

for required_path in .junie .aiassistant .devin; do
  if [ ! -d "$TARGET_PROJECT/$required_path" ]; then
    echo "Missing installed directory: $required_path"
    exit 1
  fi
done

JUNIE_SKILLS_DIR="$TARGET_PROJECT/.junie/skills"
if [ -z "$(find "$JUNIE_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit 2>/dev/null)" ]; then
  echo "No Junie skills were copied during installation."
  exit 1
fi

DEVIN_SKILLS_DIR="$TARGET_PROJECT/.devin/skills"
if [ -z "$(find "$DEVIN_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit 2>/dev/null)" ]; then
  echo "No Devin skills were copied during installation."
  exit 1
fi

if ! compgen -G "$TARGET_PROJECT/.aiassistant/rules/*.md" > /dev/null; then
  echo "No AI Assistant rules were copied during installation."
  exit 1
fi

echo "Install test passed."
