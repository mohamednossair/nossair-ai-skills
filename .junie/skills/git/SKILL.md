---
name: git
description: Git workflow and Conventional Commit message review
---

# Git Skill

Use this skill when performing Git operations or reviewing commit messages. The project follows Trunk-Based / GitFlow hybrid and strict Conventional Commits.

## Key Principles
- **Conventional Commits**: `type(scope): description`.
- **Atomic Commits**: One logical change per commit.
- **Imperative Mood**: "add feature" not "added feature".
- **Clean History**: Squash or rebase before merging.

## Guidelines

### Branching
- `main` / `master`: production-ready code only.
- `develop`: integration branch.
- `feature/*`: new features.
- `bugfix/*`: bug fixes.
- `hotfix/*`: urgent production fixes.

### Commit Message Types
- `feat`: new feature.
- `fix`: bug fix.
- `refactor`: code change without behavior change.
- `test`: adding or updating tests.
- `docs`: documentation only.
- `chore`: build, tooling, dependencies.
- `perf`: performance improvement.
- `style`: formatting, missing semicolons.

### Formatting
- **Header**: Max 72 characters, no trailing period.
- **Scope**: Optional but recommended (e.g., `feat(auth):`).
- **Body/Footer**: Separate from header with a blank line. Reference issues as `Closes #123`.

## Checklist
- [ ] Is the type valid? (`feat`, `fix`, `refactor`, etc.)
- [ ] Is the scope appropriate and lowercase?
- [ ] Is the description in imperative mood (e.g., "add", "fix", "update")?
- [ ] Does it exceed 72 characters?
- [ ] Is there a trailing period? (Should not be)
- [ ] Are logical changes separate into atomic commits?

## Examples

### Good Commit Message
```
feat(auth): add JWT refresh token support

- Implement /refresh endpoint
- Add refresh token to User model
- Update security config to allow /refresh

Closes #456
```

### Bad Commit Message
```
fixed the bug in the auth service.
```
*Wait: No type, not imperative, starts with lowercase, has a period, exceeds length.*
