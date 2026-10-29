#!/usr/bin/env bash
set -euo pipefail

# Verifies that every template announcement in the speckit/review command files is
# followed by a non-empty four-space-indented example, and that no command source
# contains escaped Markdown artifacts (backslash-escaped syntax or <br> tags).
#
# Usage:
#   ./scripts/check-contract-templates.sh

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMANDS_DIR="$REPO_DIR/.junie/commands"

failures=0
total_announces=0
total_ok=0
pat='^    [^[:space:]]'

for file in "$COMMANDS_DIR"/*.md; do
    name=$(basename "$file")

    # 1. Parser safety: no escaped Markdown syntax, no <br> anywhere in the file.
    if grep -qE '\\[-\[\]#|`]|<br>' "$file"; then
        echo "FAIL [$name] contains escaped Markdown syntax or <br>"
        failures=$((failures + 1))
    fi

    # 2. Every template announcement must be followed by a non-empty
    #    four-space-indented example within the next 3 lines.
    while IFS= read -r ln; do
        [ -z "$ln" ] && continue
        total_announces=$((total_announces + 1))
        ok=0
        for j in 1 2 3; do
            next=$(sed -n "$((ln + j))p" "$file")
            if [[ "$next" =~ $pat ]]; then
                ok=1
                total_ok=$((total_ok + 1))
                break
            fi
        done
        if [[ $ok -eq 0 ]]; then
            echo "FAIL [$name] announce at line $ln has no non-empty indented example within 3 lines"
            failures=$((failures + 1))
        fi
    done < <(grep -inE 'as normal (markdown|json|text) without the example indentation' "$file" | cut -d: -f1)
done

echo "Template announcements checked: $total_announces (followed by an example: $total_ok)"

if [[ $failures -gt 0 ]]; then
    echo "Contract template check FAILED: $failures failure(s)"
    exit 1
fi

echo "Contract template check passed: every announcement is followed by a non-empty indented example; no escaped syntax or <br> found in any command file."
