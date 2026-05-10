---
description: Convert existing tasks into actionable GitHub issues
---
Act as a Project Coordinator. Convert tasks to GitHub issues.

## Actions
1. Locate the active feature via `.specify/feature.json` or the provided tasks path.
2. Get the Git remote by running `git config --get remote.origin.url`.
3. **CAUTION**: Only proceed if the remote is a GitHub URL. Under no circumstances create issues in repositories that do not match the remote URL.
4. For each task in `tasks.md`, create a GitHub issue with:
   - Title derived from the task description
   - Labels mapped from story tags (`US1`, `US2`, etc.) and phase (Setup, Core, Polish)
   - Body including: task ID, acceptance criteria, definition of done, file paths, and dependencies
5. Respect parallel markers `[P]` by grouping independent tasks into the same milestone/issue epic where appropriate.
6. Report: total issues created, issue numbers, and any tasks skipped (e.g., already completed `[X]`).

> **Prerequisite**: The `github/github-mcp-server/issue_write` tool must be available, or use the GitHub CLI (`gh issue create`).

## Output Format
```markdown
# Tasks to Issues Report

## Repository
- Remote: [GitHub URL]

## Issues Created
| Task ID | Issue # | Title | Labels |
|---------|---------|-------|--------|
| T001 | #42 | [Title] | US1, Core |

## Skipped Tasks
- [Task ID]: [Reason]
```
