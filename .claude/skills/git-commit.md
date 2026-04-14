---
description: Create a conventional commit for current staged or unstaged changes
---
Create a git commit for the changes described or shown. Follow Conventional Commits format strictly.

## Format
```
<type>(<scope>): <short description>

[optional body - explain WHY, not what]

[optional footer: Closes #123, Breaking change: ...]
```

## Types
- `feat` - new feature (triggers minor version bump)
- `fix` - bug fix (triggers patch bump)
- `refactor` - code restructuring without behavior change
- `test` - adding or modifying tests
- `docs` - documentation only
- `chore` - build, tooling, deps, CI
- `perf` - performance improvement
- `style` - formatting (no logic change)

## Rules
- Subject line: max 72 chars, imperative mood ("add" not "added")
- No period at end of subject
- Body: explain motivation and context, not mechanics
- Breaking changes: add `BREAKING CHANGE:` footer or `!` after type: `feat!:`

## Workflow
1. Run `git status --short`, `git diff --stat`, `git diff --cached`, `git diff`, and `git branch --show-current`.
2. If there is nothing to commit, say so and stop.
3. If the current branch is `main`, `master`, or `develop`, create and switch to a new work branch before staging or committing.
4. Choose the branch prefix from the change set: `feature/`, `bugfix/`, `docs/`, or `chore/`.
5. If a Bitbucket/Jira issue ID such as `SE-123` is clearly available, include it in the branch name; otherwise use a descriptive slug without an ID.
6. Create the branch with `git switch -c <branch-name>` so local uncommitted changes stay attached to the new branch.
7. Determine the best Conventional Commit type and scope from the changes.
8. Stage the intended files if needed.
9. Run `git commit` with the generated message, adding a body when helpful.

## Examples
```
feat(auth): add JWT refresh token rotation

Tokens now rotate on each use to reduce compromise window.
Old tokens are invalidated immediately upon refresh.

Closes #234
```
```
fix(user-service): prevent NPE when profile name is null

Adds null check before trimming display name.
Reproduces when user registers without a display name field.
```
```
refactor(order): extract price calculation to PriceCalculator service
```

Output only the created commit hash and final commit message.