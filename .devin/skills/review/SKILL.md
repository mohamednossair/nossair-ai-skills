---
name: review
description: Review code in a file using the relevant technology skill and project guidelines
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

1. **Identify Technology**: from the file extension (Java, TypeScript, Python, SQL, ...).
2. **Context Gathering**:
   - Read the relevant skill from `.junie/skills/<tech>/SKILL.md`.
   - If the code handles auth, user input, secrets, or PII, also read `.junie/skills/security/SKILL.md`.
   - Read project guidelines in `.junie/guidelines.md`.
   - Read the source file provided in `$file`.
3. **In-Depth Analysis**:
   - Analyze the code against SOLID, DRY, and Clean Code principles.
   - Check against specific technology standards (e.g., Signals in Angular, Virtual Threads in Java 21, PEP 8 in Python).
   - Evaluate security using the `security` skill (`.junie/skills/security/SKILL.md`) whenever the code handles auth, user input, secrets, or PII.
   - Evaluate performance using the `performance` skill (`.junie/skills/performance/SKILL.md`) for hot paths, queries, and list endpoints.
   - Evaluate accessibility using the `accessibility` skill (`.junie/skills/accessibility/SKILL.md`) for UI templates and forms.
   - Verify alignment with project-specific patterns (Layers in Spring Boot, standalone components in Angular).
4. **Produce Technical Review Report** as clean, readable Markdown:

### Technical Review: [File Name]

**Summary**: high-level assessment (e.g., "Good", "Needs Refactoring", "Critical Issues Found") plus the component's purpose in business terms.

**Scorecard**: Logic Correctness, Security & Data Safety, Performance & Scalability, Maintainability & Readability, Testability.

**Detailed Findings** — group by severity: [Critical] | [Warning] | [Suggestion]. For each finding include:
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Why**: [Impact: security risk, memory leak, technical debt, etc.]
- **Recommendation & Fix**: [Concrete correction or code snippet]

**Code Pattern Alignment**: how well the code follows `.junie/guidelines.md`; highlight exceptional patterns.

**Testing Assessment**: existing coverage (if detectable) or specific test cases to add (happy path, edge cases, error paths).

**Conclusion & Next Steps**: actionable advice and a suggested follow-up (e.g., `/test-generate file="..."`).
