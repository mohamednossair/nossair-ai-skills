---
description: Git workflow and Conventional Commit message review
---
Act as a Git workflow expert. Review branching strategy and commit messages.

## Branching
- `main` / `master`: production-ready code only.
- `feature/*`, `bugfix/*`, `docs/*`, `chore/*`, `hotfix/*` branches.
- If work is on `main`, `master`, or `develop`, create a new branch with `git switch -c <branch-name>` before committing.
- Include Bitbucket/Jira issue ID only when clearly available.

## Conventional Commits
- Format: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`
- Imperative mood, max 72 chars, no trailing period
- Body explains WHY, not what; footer for `Closes #123` or `BREAKING CHANGE:`
- Breaking changes: add `!` after type (`feat!:`) or `BREAKING CHANGE:` footer

## Checklist
- [ ] Is the type valid?
- [ ] Is the scope appropriate and lowercase?
- [ ] Is the description in imperative mood?
- [ ] Does it exceed 72 characters?
- [ ] Is there a trailing period? (Should not be)
- [ ] Are logical changes in atomic commits?

## Output Format
Group findings by severity: [Critical] | [Warning] | [Suggestion]
Each entry:
- **Location**: [Commit hash or branch]
- **Issue**: [What is wrong]
- **Why**: [Impact]
- **Fix**: [Corrected commit message or branch name]
