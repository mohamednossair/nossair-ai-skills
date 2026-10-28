---
name: review-pr
description: Review a pull request or branch diff (multi-file review) with change inventory, cross-file consistency, and merge recommendation
argument-hint: '[base]'
allowed-tools:
  - read
  - grep
  - glob
  - exec
permissions:
  allow:
    - Exec(git diff*)
    - Exec(git log*)
    - Exec(git merge-base*)
    - Exec(git branch*)
triggers:
  - user
  - model
---

Review the pull request or branch diff provided (or the current branch against its base).

1. **Determine the change set**:
   - If a base ref is provided, use it; otherwise diff the current branch against `main`, `master`, or `develop` (whichever exists).
   - Collect: `git merge-base HEAD <base>`, `git diff --stat <base>...HEAD`, `git diff <base>...HEAD`, `git log --oneline <base>..HEAD`.
2. **Scope the review**:
   - List changed files and group them by technology.
   - Load the relevant `.junie/skills/<tech>/SKILL.md` for each technology.
   - Load `.junie/skills/security/SKILL.md` when auth, user input, secrets, or PII are touched.
   - Read `.junie/guidelines.md`.
3. **Review layers**: per-file findings, cross-file consistency (API contracts, DTO shapes, error handling, entity changes vs. Flyway migrations), commit hygiene (Conventional Commits, atomic commits), and test coverage of new or changed behaviors.
4. **Produce PR Review Report** as clean Markdown:

### PR Review: [branch or PR title]

**Summary**: what the PR does in business terms; overall assessment.

**Change Inventory**: table of files → purpose → risk (High / Medium / Low).

**Detailed Findings** — group by severity: [Critical] | [Warning] | [Suggestion]. For each finding include:
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Why**: [Impact]
- **Recommendation & Fix**: [Concrete correction or code snippet]

**Cross-File Consistency**: contract mismatches, missing migrations, orphaned code, incomplete refactors.

**Test Coverage Assessment**: covered behaviors and specific missing cases.

**Merge Recommendation**: Approve / Approve with comments / Request changes — with required follow-ups.

5. Keep findings actionable and scoped to the diff — do not re-review unchanged code.
