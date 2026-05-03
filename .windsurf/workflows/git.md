---
description: Git workflow, branching strategy, and Conventional Commits
---

**Usage**: `/git` or when reviewing Git operations.

## Branching
- `main` / `master`: production-ready code only.
- `develop`: integration branch.
- `feature/*`, `bugfix/*`, `docs/*`, `chore/*`, `hotfix/*` branches.
- If work is on `main`, `master`, or `develop`, create a new branch with `git switch -c <branch-name>`.
- Include Bitbucket/Jira issue ID only when clearly available.

## Conventional Commits
- Format: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`
- Imperative mood, max 72 chars, no trailing period
- Breaking changes: add `!` after type (`feat!:`) or `BREAKING CHANGE:` footer

## Checklist
- [ ] Is the type valid?
- [ ] Is the scope appropriate and lowercase?
- [ ] Is the description in imperative mood?
- [ ] Does it exceed 72 characters?
- [ ] Is there a trailing period? (Should not be)
- [ ] Are logical changes in atomic commits?
