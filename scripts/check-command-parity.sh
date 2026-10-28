#!/bin/bash
# check-command-parity.sh
# Verifies the 4 unified command contracts stay aligned across Junie and Devin.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

checks=(
  'review|.junie/commands/review.md|.devin/skills/review/SKILL.md|\[Critical\] \| \[Warning\] \| \[Suggestion\]'
  'review-pr|.junie/commands/review-pr.md|.devin/skills/review-pr/SKILL.md|\[Critical\] \| \[Warning\] \| \[Suggestion\]'
  'review-pr-merge|.junie/commands/review-pr.md|.devin/skills/review-pr/SKILL.md|Merge Recommendation'
  'plan|.junie/commands/plan.md|.devin/skills/plan/SKILL.md|Risk'
  'test-generate|.junie/commands/test-generate.md|.devin/skills/test-generate/SKILL.md|pytest'
  'git-commit|.junie/commands/git-commit.md|.devin/skills/git-commit/SKILL.md|run `git commit`'
  'git-commit-result|.junie/commands/git-commit.md|.devin/skills/git-commit/SKILL.md|created commit hash and final commit message'
)

failures=()

for entry in "${checks[@]}"; do
  IFS='|' read -r name junie devin pattern <<< "$entry"
  for rel in "$junie" "$devin"; do
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

# Junie commands must not use unsupported frontmatter
for junie_dir in "$REPO_DIR"/.junie/commands/*.md; do
  [[ -f "$junie_dir" ]] || continue
  rel=".junie/commands/$(basename "$junie_dir")"
  if grep -Eq '^name:' "$junie_dir"; then
    failures+=("Junie command uses unsupported 'name' frontmatter: $rel")
  fi
  if grep -Eq '^arguments:' "$junie_dir"; then
    failures+=("Junie command uses unsupported 'arguments' frontmatter: $rel")
  fi
done

# Devin skills must have required frontmatter
while IFS= read -r -d '' skill_file; do
  rel=".devin/skills/${skill_file#"$REPO_DIR"/.devin/skills/}"
  if ! grep -Eq '^name:' "$skill_file"; then
    failures+=("Devin skill missing 'name' frontmatter: $rel")
  fi
  if ! grep -Eq '^description:' "$skill_file"; then
    failures+=("Devin skill missing 'description' frontmatter: $rel")
  fi
done < <(find "$REPO_DIR/.devin/skills" -name 'SKILL.md' -type f -print0 2>/dev/null)

if (( ${#failures[@]} > 0 )); then
  echo "Command parity check failed:"
  for f in "${failures[@]}"; do
    echo "- $f"
  done
  exit 1
fi

echo "Command parity check passed."
