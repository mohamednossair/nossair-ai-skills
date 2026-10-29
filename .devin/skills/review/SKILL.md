---
name: review
description: Review code in a file using the relevant technology skill and project guidelines — strictly read-only, evidence-backed findings with confidence, scorecard model, and a final verdict (PASS / PASS_WITH_COMMENTS / CHANGES_RECOMMENDED / CRITICAL_CHANGES_REQUIRED)
argument-hint: 'file="path/to/file"'
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Review the code file provided in `$file` (or the file the user is discussing).

1. Read and follow `.junie/commands/review.md` exactly — it is the source of truth for all agents (Safety contract, technology-detection chain, minimum-adjacent-context rule, shared finding schema, scorecard model, and final verdict).
2. Findings are grouped by severity: [Critical] | [Warning] | [Suggestion] — every Critical and Warning finding carries Location, Evidence, Standard, Confidence, Impact, Recommendation, and Scope; never report speculation as confirmed.
3. End with the final verdict: PASS | PASS_WITH_COMMENTS | CHANGES_RECOMMENDED | CRITICAL_CHANGES_REQUIRED (precedence order).
