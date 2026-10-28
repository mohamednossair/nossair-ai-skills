---
description: Review a pull request or a set of changes (multi-file diff review) using relevant tech skills and guidelines.
---

**Usage**: `/review-pr [base]` (e.g., `/review-pr`, `/review-pr main`, `/review-pr origin/develop...HEAD`)

1. **Determine the change set**:
   - If a base ref is provided, use it; otherwise diff the current branch against `main`, `master`, or `develop` (whichever exists).
   - Collect: `git merge-base HEAD <base>`, `git diff --stat <base>...HEAD`, `git diff <base>...HEAD`, `git log --oneline <base>..HEAD`.
2. **Scope the review**:
   - List changed files and group them by technology.
   - Load the relevant `.junie/skills/<tech>/SKILL.md` for each technology.
   - Load `.junie/skills/security/SKILL.md` when auth, user input, secrets, or PII are touched.
   - Read `.junie/guidelines.md`.
3. **Review layers**:
   - Per-file findings (same format as `/review`).
   - Cross-file consistency: API contracts, DTO shapes, naming, error handling, entity changes vs. Flyway migrations.
   - Commit hygiene: Conventional Commits, atomic commits (see the `git` skill).
   - Tests: are new or changed behaviors covered? Suggest specific cases (happy path, edge cases, error paths).
4. **Produce PR Review Report** as clean Markdown:

### PR Review: [branch or PR title]

**Summary**: what the PR does in business terms; overall assessment.

**Change Inventory**: table of files → purpose → risk (High / Medium / Low).

**Detailed Findings** — group by severity: [Critical] | [Warning] | [Suggestion]. For each finding include:
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Why**: [Impact: security risk, performance, technical debt]
- **Recommendation & Fix**: [Concrete correction or code snippet]

**Cross-File Consistency**: contract mismatches, missing migrations, orphaned code, incomplete refactors.

**Test Coverage Assessment**: covered behaviors and specific missing cases.

**Merge Recommendation**: Approve / Approve with comments / Request changes — with required follow-ups (e.g., "add migration for new column", "cover error path in tests").

5. **Format**: keep findings actionable and scoped to the diff — do not re-review unchanged code.
