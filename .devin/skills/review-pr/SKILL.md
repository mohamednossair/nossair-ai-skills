---
name: review-pr
description: Review a pull request or branch diff (multi-file review) with deterministic base resolution, scope=committed|working-tree|all, file classification, SpecKit integration, coverage matrix, and merge recommendation — strictly read-only
argument-hint: '[base] [scope="committed|working-tree|all"]'
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
    - Exec(git status*)
triggers:
  - user
  - model
---

Review the pull request or branch diff provided (or the current branch against its base).

1. Read and follow `.junie/commands/review-pr.md` exactly — it is the source of truth for all agents (deterministic base resolution, `scope=committed|working-tree|all`, read-only safety, file classification, SpecKit integration, shared finding schema, coverage matrix, and merge gates).
2. Findings are grouped by severity: [Critical] | [Warning] | [Suggestion] — every Critical and Warning finding carries Location, Evidence, Standard, Confidence, Impact, Recommendation, and Scope; never re-review unchanged code.
3. End with the Merge Recommendation: APPROVE | APPROVE_WITH_COMMENTS | REQUEST_CHANGES — BLOCKED when the base cannot be resolved (never guess among several candidate branches).
