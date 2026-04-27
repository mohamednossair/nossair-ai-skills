---
description: Review code in a file using relevant tech skill and guidelines.
---

**Usage**: `/review file="<path>"`

1. **Identify Technology**: Determine the technology used (Java, TypeScript, Python, etc.) from the file extension.
2. **Context Gathering**: 
   - Read the relevant skill from `.junie/skills/<tech>/SKILL.md`.
   - Read project guidelines in `.junie/guidelines.md`.
   - Read the source file provided in `$file`.
3. **In-Depth Analysis**:
   - Analyze the code against SOLID, DRY, and Clean Code principles.
   - Check against specific technology standards (e.g., Signals in Angular, Virtual Threads in Java 21, PEP 8 in Python).
   - Evaluate security (OWASP Top 10), performance (O-notation, resource leaks), and maintainability.
   - Verify alignment with project-specific patterns (Layers in Spring Boot, standalone components in Angular).
4. **Produce Technical Review Report**:
   - Generate a full, structured technical document with the following sections:

### Technical Review: [File Name]

**Summary**: 
- Provide a high-level assessment of the code quality (e.g., "Good", "Needs Refactoring", "Critical Issues Found").
- Briefly explain the primary purpose of the component/file in business terms.

**Scorecard**:
- [ ] Logic Correctness
- [ ] Security & Data Safety
- [ ] Performance & Scalability
- [ ] Maintainability & Readability
- [ ] Testability

**Detailed Findings**:
Group findings by severity: [Critical] | [Warning] | [Suggestion].
For each finding, include:
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Impact**: [Why it matters: security risk, memory leak, technical debt, etc.]
- **Recommendation & Fix**: [Concrete correction or code snippet]

**Code Pattern Alignment**:
- List how well the code follows project-specific standards (from `.junie/guidelines.md`).
- Highlight any innovative or exceptionally well-written patterns.

**Testing Assessment**:
- Evaluate existing test coverage (if detectable) or suggest specific test cases (Happy path, Edge cases, Error paths) that should be implemented.

**Conclusion & Next Steps**:
- Actionable advice for the developer (e.g., "Fix critical issues before merging", "Refactor the complex method into smaller ones").
- Suggested follow-up command (e.g., `/test-generate file="..."` to cover missing cases).

5. **Format**: The output must be a clean, readable Markdown document.
