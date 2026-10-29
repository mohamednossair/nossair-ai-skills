---
description: Review code in a file using relevant tech skill and guidelines.
---

**Usage**: `/review file="<path>"`

## Safety

This command is strictly read-only.

- Do not modify the reviewed file.
- Do not generate or update tests.
- Do not apply formatting.
- Do not execute destructive or state-changing commands.
- A command counts as read-only only if it does not modify the working tree or persistent project files. Before and after every executed command, capture Git working-tree status and report created or modified files; a command producing build artifacts only in ignored paths is classified non-source-mutating, not strictly read-only. Never clean, delete, reset, or restore files automatically.
- Read-only build or static-analysis commands may run only when the repository supports them, and every executed command is reported with its read-only status.

**Output destination**: the report is returned in command output only — do not write a report file (a separate explicit output path and write mode would be required for that).

1. **Identify Technology** — resolve in this priority: (1) file extension; (2) nearby project manifest; (3) imports and annotations; (4) repository structure; (5) the plan's `## Standards` section when available; (6) the relevant technology skill. Repository configuration determines the actual technology in use; plan Standards provide intended standards and may reveal drift — when they conflict, apply repository-compatible review rules, report the standards drift, and do not pretend an unavailable framework or version is active. If technology remains ambiguous, report which standards were applied instead of guessing.
2. **Context Gathering**:
   - Read the relevant skill from `.junie/skills/<tech>/SKILL.md`.
   - Read project guidelines in `.junie/guidelines.md`.
   - Read the source file provided in `$file`.
   - Read the minimum adjacent context necessary to review the selected file: imported local interfaces and types; directly associated template or stylesheet; tests for the selected symbol; configuration directly controlling behavior; callers or callees only when required to verify a finding. Do not expand into an unrestricted repository review; report every contextual file inspected.
3. **In-Depth Analysis**:
   - Analyze the code against SOLID, DRY, and Clean Code principles.
   - Check against specific technology standards (e.g., Signals in Angular, Virtual Threads in Java 21, PEP 8 in Python).
   - Evaluate security using the `security` skill (`.junie/skills/security/SKILL.md`) whenever the code handles auth, user input, secrets, or PII.
   - Evaluate performance using the `performance` skill (`.junie/skills/performance/SKILL.md`) for hot paths, queries, and list endpoints.
   - Evaluate accessibility using the `accessibility` skill (`.junie/skills/accessibility/SKILL.md`) for UI templates and forms.
   - Verify alignment with project-specific patterns (Layers in Spring Boot, standalone components in Angular).
4. **Produce Technical Review Report**:
   - Return a structured Markdown review in command output — do not create or modify a report file.
   - Generate the report with the following sections:

### Technical Review: [File Name]

**Summary**:
- Provide a high-level assessment of the code quality (e.g., "Good", "Needs Refactoring", "Critical Issues Found").
- Briefly explain the primary purpose of the component/file in business terms.

**Scorecard** — dimensions: Logic Correctness · Security & Data Safety · Performance & Scalability · Maintainability & Readability · Testability; scale per dimension: 5 = Excellent, 4 = Good, 3 = Acceptable with improvements, 2 = Significant concerns, 1 = Critical, N/A = Not applicable; columns: `Dimension` · `Score` · `Evidence`; do not compute an overall average when any dimension is 1 — generate as normal Markdown without the example indentation:

    ## Scorecard

    | Dimension | Score | Evidence |
    |---|---:|---|
    | Logic Correctness | 4 | Core behavior is clear; one boundary is unverified |
    | Security & Data Safety | 5 | No unsafe input handling found |
    | Performance & Scalability | N/A | No relevant hot path |
    | Maintainability & Readability | 3 | Method responsibilities overlap |
    | Testability | 2 | External dependency is constructed directly |

**Detailed Findings**:
Group findings by severity: [Critical] | [Warning] | [Suggestion].
Every Critical and Warning finding uses this shared schema — fields: `Location` (`<path>:<line range or symbol>`) · `Evidence` (specific observed code or behavior) · `Standard` (`<skill or guideline section>`) · `Confidence` (`Confirmed | Likely | Needs runtime verification`) · `Impact` (concrete consequence) · `Recommendation` (specific, scoped correction) · `Scope` (`Reviewed file | Required adjacent context`) — generate it as normal Markdown without the example indentation:

    ### WARNING-003: Missing rejection-path coverage

    - Location: `src/test/.../DocumentServiceTest.java`
    - Evidence: Only the successful transition is tested.
    - Standard: `java/SKILL.md#testing`
    - Confidence: Confirmed | Likely | Needs runtime verification
    - Impact: Invalid transitions may regress without detection.
    - Recommendation: Add a test for unsupported source and target status combinations.
    - Scope: Reviewed file

Do not report speculation as confirmed; Suggestions may be design improvements but must remain scoped. Finding IDs are stable per report and zero-padded per severity: `CRITICAL-001`, `WARNING-001`, `SUGGESTION-001`. Suggestions use the same structure with `Standard: Design improvement` when no mandatory rule applies, plus a `Benefit` field (expected improvement) — generate a suggestion as normal Markdown without the example indentation:

    ### SUGGESTION-001: <concise improvement>

    - Location:
    - Evidence:
    - Standard: Design improvement
    - Confidence:
    - Benefit:
    - Recommendation:
    - Scope:

**Code Pattern Alignment**:
- List how well the code follows project-specific standards (from `.junie/guidelines.md`).
- Highlight any innovative or exceptionally well-written patterns.

**Testing Assessment** — fields: `Existing tests inspected` · `Test execution performed` (Yes | No) · `Commands executed` · `Covered behaviors` · `Missing behaviors` · `Required test level` (Unit | Integration | Contract | UI | Performance | Security) · `Evidence status` (VERIFIED | STATIC_ONLY | MISSING | UNVERIFIABLE) · `Recommended test task` — generate as normal Markdown without the example indentation:

    ## Testing Assessment

    - Existing tests inspected:
    - Test execution performed: Yes | No
    - Commands executed:
    - Covered behaviors:
    - Missing behaviors:
    - Required test level: Unit | Integration | Contract | UI | Performance | Security
    - Evidence status: VERIFIED | STATIC_ONLY | MISSING | UNVERIFIABLE
    - Recommended test task:

Rules: no tests found → `Existing tests inspected: None found` and `Evidence status: MISSING`; tests exist but were not run → `Evidence status: STATIC_ONLY`.

**Conclusion & Next Steps**:
- Actionable advice for the developer (e.g., "Fix critical issues before merging", "Refactor the complex method into smaller ones").
- Suggested follow-up command (e.g., `/speckit.test-generate file="..."` to cover missing cases).

5. **Final verdict** (required, precedence order):
   - **CRITICAL_CHANGES_REQUIRED** — one or more Critical findings.
   - **CHANGES_RECOMMENDED** — no Critical findings, but one or more Warning findings; also applies when material behavior cannot be verified because required adjacent context or test evidence is unavailable — never mark material uncertainty as PASS.
   - **PASS_WITH_COMMENTS** — Suggestions only.
   - **PASS** — no material findings.

End the report with a verdict summary — fields: `Verdict` (PASS | PASS_WITH_COMMENTS | CHANGES_RECOMMENDED | CRITICAL_CHANGES_REQUIRED) · `Critical findings` · `Warnings` · `Suggestions` · `Files inspected` · `Commands executed` · `Working-tree changes caused by review` (None | details) · `Recommended next command` — generate as normal Markdown without the example indentation:

    ## Review Result

    - Verdict: PASS | PASS_WITH_COMMENTS | CHANGES_RECOMMENDED | CRITICAL_CHANGES_REQUIRED
    - Critical findings:
    - Warnings:
    - Suggestions:
    - Files inspected:
    - Commands executed:
    - Working-tree changes caused by review: None | <details>
    - Recommended next command:

6. **Format**: The output must be a clean, readable Markdown document.
