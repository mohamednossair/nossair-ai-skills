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
1. Run `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff`.
2. If there is nothing to commit, say so and stop.
3. Determine the best Conventional Commit type and scope from the changes.
4. Stage the intended files if needed.
5. Run `git commit` with the generated message, adding a body when helpful.

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