---
description: Review a pull request or a set of changes (multi-file diff review) using relevant tech skills and guidelines.
---

**Usage**: `/review-pr [base] [scope="committed|working-tree|all"]` (e.g., `/review-pr`, `/review-pr base="origin/develop" scope="committed"`, `/review-pr main`)

## Safety

Strictly read-only: do not modify files, do not create/switch/rebase/merge branches, do not amend commits, do not stage changes. Report every command executed and whether it was read-only. Before and after any command beyond basic Git inspection: capture Git working-tree status, report created or modified files, never clean/reset/restore/delete generated artifacts, and classify commands that only create ignored build artifacts as non-source-mutating — not strictly read-only.

1. **Resolve the base ref (deterministic)**:
   1. Explicit base argument.
   2. PR metadata base branch, when available.
   3. Upstream tracking or configured default branch.
   4. Remote symbolic default branch (e.g. `origin/HEAD`).
   5. Exactly one of `main`/`master`/`develop`.
   6. Structured ambiguity error when multiple candidates remain — never guess among several existing branches.
   If the base cannot be resolved: do not guess another branch; return BLOCKED; list available candidate refs; do not produce a merge recommendation from an incomplete diff.
2. **Determine the change set** per `scope` (default `committed`):
   - `base` is a single Git ref (preferred input). Backward compatibility: a positional legacy argument may be a complete revision range — if the input contains `..` or `...`, treat it as a range and use it exactly; never pass a range to `git merge-base`; never append `...HEAD` to an explicit range. For a plain ref, diff `<base>...HEAD`. For an explicit range, report `Base reference: Not separately resolved`, `Explicit revision range: <range>`, and `Merge base: Derived only when both range endpoints can be safely resolved`.
   - `committed` — `git merge-base HEAD <base>`, `git diff --stat <base>...HEAD`, `git diff <base>...HEAD`, `git log --oneline <base>..HEAD`.
   - `working-tree` — staged, unstaged, and relevant untracked changes. Relevant untracked files: reside under source/test/configuration/migration/documentation roots, are referenced by a changed tracked file, match manifest-recognized source patterns, or are explicitly user-supplied; exclude build outputs, caches, IDE metadata, and ignored files unless the user explicitly requests them.
   - `all` — committed branch changes plus working-tree changes, each category reported separately.
3. **Scope the review**: list changed files, classify each (`source | test | configuration | migration | generated | dependency metadata | documentation`), group by technology; load the relevant `.junie/skills/<tech>/SKILL.md` per technology; load `.junie/skills/security/SKILL.md` when auth, user input, secrets, or PII are touched; read `.junie/guidelines.md`. Review generated files primarily for expected presence, alignment with the source change, unexpected manual edits, and dependency/supply-chain effects — do not apply ordinary clean-code findings to machine-generated content.
4. **SpecKit integration (when available)** — if `.specify/feature.json` or explicit artifact paths resolve: map changed files to selected tasks; check AC/NFR/TR coverage; detect changed files outside task scope. Priority: reuse a valid post-implementation analysis report for the same Git state (verify its commit/base metadata) when one exists; otherwise recommend or invoke read-only `/speckit.analyze mode="post-implementation"` when permitted; do not independently recreate the full SpecKit semantic analysis inside `/review-pr`. Do not require SpecKit artifacts for ordinary PRs.
5. **Review layers**:
   - Per-file findings (same shared schema as `/review`).
   - Cross-file consistency: API contracts, DTO shapes, naming, error handling, entity changes vs. Flyway migrations.
   - Commit hygiene: Conventional Commits, atomic commits (see the `git` skill). Constitution- or repository-required commit-rule violations → Warning or Critical as configured; general commit-style preferences → Suggestion only. Each commit-hygiene finding states its rule authority: Constitution | Repository guidelines | Git skill | General recommendation.
   - Tests: map changed behavior to coverage using the matrix below; suggest specific missing cases (happy path, edge cases, error paths).
6. **Produce PR Review Report** as clean Markdown:

### PR Review: [branch or PR title]

**Summary**: what the PR does in business terms; overall assessment.

**Scope** — fields: `Selected scope` (committed | working-tree | all) · `Base reference` · `Head reference` · `Merge base` · `Explicit revision range` · `Included committed files` · `Included staged files` · `Included unstaged files` · `Included untracked files` · `Excluded ignored files` · `Excluded build outputs` · `Excluded unrelated untracked files` · `SpecKit artifacts used` — generate as normal Markdown without the example indentation (use `Not applicable` where required rather than omitting fields):

    ## Scope

    - Selected scope: committed | working-tree | all
    - Base reference:
    - Head reference:
    - Merge base:
    - Explicit revision range:
    - Included committed files:
    - Included staged files:
    - Included unstaged files:
    - Included untracked files:
    - Excluded ignored files:
    - Excluded build outputs:
    - Excluded unrelated untracked files:
    - SpecKit artifacts used:

**Change Inventory** — columns: `File` · `Classification` · `Technology` · `Purpose` · `Risk` (High / Medium / Low) — generate as normal Markdown without the example indentation:

    ## Change Inventory

    | File | Classification | Technology | Purpose | Risk |
    |---|---|---|---|---|
    | `src/.../DocumentService.java` | source | Java / Spring Boot | Enforces document state transitions | High |

**Detailed Findings** — group by severity: [Critical] | [Warning] | [Suggestion]; every Critical and Warning finding uses this shared schema — fields: `Location` (`<path>:<line range or symbol>`) · `Evidence` (specific changed code or cross-file interaction) · `Standard` (`<skill or guideline section>`) · `Confidence` (`Confirmed | Likely | Needs runtime verification`) · `Impact` (concrete consequence) · `Recommendation` (specific correction) · `Scope` (`Changed behavior | Required unchanged context`) — generate it as normal Markdown without the example indentation:

    ### WARNING-001: <concise finding title>

    - Location: `<file>:<line or symbol>`
    - Evidence: <specific observed code or behavior>
    - Standard: `<skill or guideline section>`
    - Confidence: Confirmed | Likely | Needs runtime verification
    - Impact: <business or technical consequence>
    - Recommendation:
    - Scope: Changed behavior

Finding IDs are stable per report and zero-padded per severity: `CRITICAL-001`, `WARNING-001`, `SUGGESTION-001`.

**Cross-File Consistency**: contract mismatches, missing migrations, orphaned code, incomplete refactors.

**Test Coverage Assessment** — columns: `Changed behavior` · `Requirement or task` · `Existing test` · `Coverage status` · `Evidence`; statuses: `COMPLETE | PARTIAL | MISSING | UNVERIFIABLE`; plus summary counts (`Complete behaviors`, `Partial behaviors`, `Missing behaviors`, `Unverifiable behaviors`) — generate the matrix and counts as normal Markdown without the example indentation:

    ## Test Coverage Assessment

    | Changed behavior | Requirement or task | Existing test | Coverage status | Evidence |
    |---|---|---|---|---|
    | Reject invalid transition | AC-004 / T013 | `DocumentServiceTest` | COMPLETE | Rejection assertion exists |
    | Preserve audit record | NFR-OPS-002 | None | MISSING | No matching test found |

    - Complete behaviors:
    - Partial behaviors:
    - Missing behaviors:
    - Unverifiable behaviors:

Statuses: `COMPLETE | PARTIAL | MISSING | UNVERIFIABLE`.

**Severity semantics** — CRITICAL blocks merge; WARNING is a material but non-blocking concern (merge may proceed only when the repository does not classify the underlying rule as mandatory — promote a Warning to Critical when it represents a mandatory repository or constitution violation); SUGGESTION is an optional improvement.

**Merge Recommendation** — deterministic rules, precedence BLOCKED → REQUEST_CHANGES → APPROVE_WITH_COMMENTS → APPROVE:
- **BLOCKED** — the base reference cannot be resolved; the diff cannot be read completely; required repository metadata is unavailable; the selected scope is internally inconsistent; or review evidence is insufficient to produce a reliable merge recommendation. A blocked review does not imply code defects — it means a reliable review could not be completed.
- **REQUEST_CHANGES** — any Critical finding; a missing required migration; a broken contract; a security regression; failing required test evidence; or uncovered material behavior change.
- **APPROVE_WITH_COMMENTS** — no blocking finding; only Warning or Suggestion findings.
- **APPROVE** — no Critical or Warning findings; required behavior has adequate test evidence.

End the report with a standard summary — fields: `Recommendation` (BLOCKED | REQUEST_CHANGES | APPROVE_WITH_COMMENTS | APPROVE) · `Critical findings` · `Warnings` · `Suggestions` · `Changed behaviors reviewed` · `Complete test coverage` · `Partial test coverage` · `Missing test coverage` · `Unverifiable test coverage` · `Files included` · `Files excluded` · `Commands executed` · `Recommended next command` — generate as normal Markdown without the example indentation:

    ## PR Review Result

    - Recommendation: BLOCKED | REQUEST_CHANGES | APPROVE_WITH_COMMENTS | APPROVE
    - Critical findings:
    - Warnings:
    - Suggestions:
    - Changed behaviors reviewed:
    - Complete test coverage:
    - Partial test coverage:
    - Missing test coverage:
    - Unverifiable test coverage:
    - Files included:
    - Files excluded:
    - Commands executed:
    - Recommended next command:

7. **Format**: keep findings actionable and scoped to the diff — do not re-review unchanged code. If adjacent unchanged code is necessary to explain a changed-code defect, cite it as context, not as a separate unrelated finding.
