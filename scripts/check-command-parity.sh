#!/bin/bash
# check-command-parity.sh
# Verifies the 4 unified command contracts stay aligned across Claude, Junie, and Windsurf.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

checks=(
  "review|.claude/skills/review.md|.junie/commands/review.md|.windsurf/memories/commands-reference.md|\\[Critical\\] \\| \\[Warning\\] \\| \\[Suggestion\\]"
  "plan|.claude/skills/plan.md|.junie/commands/plan.md|.windsurf/memories/commands-reference.md|Risk"
  "test-generate|.claude/skills/test-generate.md|.junie/commands/test-generate.md|.windsurf/memories/commands-reference.md|pytest"
  "git-commit|.claude/skills/git-commit.md|.junie/commands/git-commit.md|.windsurf/memories/commands-reference.md|run \\`git commit\\`"
  "git-commit-result|.claude/skills/git-commit.md|.junie/commands/git-commit.md|.windsurf/memories/commands-reference.md|created commit hash and final commit message"
)

failures=()

for entry in "${checks[@]}"; do
  IFS='|' read -r name claude junie windsurf pattern <<< "$entry"
  for rel in "$claude" "$junie" "$windsurf"; do
    path="$REPO_DIR/$rel"
    if [[ ! -f "$path" ]]; then
      failures+=("Missing file: $rel")
      continue
    fi
    if ! grep -Eq "$pattern" "$path"; then
      failures+=("[$name] pattern '$pattern' not found in $rel")
    fi
  done
done

for entry in "${checks[@]}"; do
  IFS='|' read -r _ _ junie _ _ <<< "$entry"
  path="$REPO_DIR/$junie"
  if [[ ! -f "$path" ]]; then
    continue
  fi
  if grep -Eq '^name:' "$path"; then
    failures+=("Junie command uses unsupported 'name' frontmatter: $junie")
  fi
  if grep -Eq '^arguments:' "$path"; then
    failures+=("Junie command uses unsupported 'arguments' frontmatter: $junie")
  fi
done

if (( ${#failures[@]} > 0 )); then
  echo "Command parity check failed:"
  for f in "${failures[@]}"; do
    echo "- $f"
  done
  exit 1
fi

echo "Command parity check passed."