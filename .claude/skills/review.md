---
description: Review code in a file using the relevant technology skill and project guidelines.
---
Act as a Senior Software Engineer. Review the provided code file.

## Actions
1. Identify the technology from the file extension (Java, TypeScript, Python, etc.).
2. Apply the relevant coding standards and best practices for that technology.
3. Analyze: correctness, security, performance, readability, SOLID/DRY compliance.
4. Provide actionable improvements with code snippets.

## Output Format
Group findings by severity: 🔴 Critical | 🟡 Warning | 🔵 Suggestion
Each entry:
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Why**: [Impact: security, performance, maintainability]
- **Fix**: [Corrected code snippet]
