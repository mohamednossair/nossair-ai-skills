#!/usr/bin/env bash
set -euo pipefail

# Creates a work branch if currently on a protected branch (main/master/develop).
#
# Usage:
#   ./create-branch.sh --prefix "feature/spec" --short-name "auth-refresh" [--issue-id "SE-123"]
#
# Outputs JSON with branch name, previous branch, and whether a new branch was created.

PREFIX=""
SHORT_NAME=""
ISSUE_ID=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --prefix) PREFIX="$2"; shift 2 ;;
    --short-name) SHORT_NAME="$2"; shift 2 ;;
    --issue-id) ISSUE_ID="$2"; shift 2 ;;
    *) echo '{"error":"Unknown argument: '$1'"}'; exit 1 ;;
  esac
done

if [[ -z "$PREFIX" || -z "$SHORT_NAME" ]]; then
  echo '{"error":"--prefix and --short-name are required"}'
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo '{"error":"Not inside a git repository"}'
  exit 1
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
PREVIOUS_BRANCH="$CURRENT_BRANCH"

PROTECTED="main master develop"
IS_PROTECTED=0
for pb in $PROTECTED; do
  if [[ "$CURRENT_BRANCH" == "$pb" ]]; then
    IS_PROTECTED=1
    break
  fi
done

if [[ $IS_PROTECTED -eq 0 ]]; then
  printf '{"created":false,"currentBranch":"%s","previousBranch":"%s","branchName":"%s"}\n' \
    "$CURRENT_BRANCH" "$PREVIOUS_BRANCH" "$CURRENT_BRANCH"
  exit 0
fi

SLUG=$(echo "$SHORT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
if [[ -n "$ISSUE_ID" ]]; then
  BRANCH_NAME="$PREFIX/$ISSUE_ID-$SLUG"
else
  BRANCH_NAME="$PREFIX/$SLUG"
fi

if ! git switch -c "$BRANCH_NAME" >/dev/null 2>&1; then
  printf '{"error":"Failed to create branch %s"}\n' "$BRANCH_NAME"
  exit 1
fi

printf '{"created":true,"currentBranch":"%s","previousBranch":"%s","branchName":"%s"}\n' \
  "$BRANCH_NAME" "$PREVIOUS_BRANCH" "$BRANCH_NAME"
