---
description: Review code in a file using the relevant skill and guidelines.
---
Review the code in $file.
1. Identify the technology used (Java, TypeScript, Python, etc.) from the file extension.
2. Read the relevant skill from `.junie/skills/<tech>/SKILL.md` and the project guidelines in `.junie/guidelines.md`.
3. Analyze the code against the principles, guidelines, and checklist from the skill.
4. Provide findings grouped by severity: [Critical] | [Warning] | [Suggestion].
5. For each finding, include:
   - **Location**: [File:line]
   - **Issue**: [What is wrong]
   - **Why**: [Impact: security, performance, maintainability]
   - **Fix**: [Concrete correction or snippet]
