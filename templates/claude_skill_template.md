---
description: [One-line description shown in the /skill list — be specific]
---
[This is the prompt Claude receives when you type /skill-name in Claude Code.]
[Act as a Senior [Technology] Expert. Be direct, technical, and include why each issue matters.]

## Review Guidelines
[Describe what Claude should check for in this specific tech stack.]

**[Category 1, e.g., API Design]**
- [Check 1, e.g., RESTful endpoints use plural nouns]
- [Check 2, e.g., HTTP status codes are correct]

**[Category 2, e.g., Reactivity]**
- [Check 1, e.g., signals used for state management]

## Output Format
[Define the response structure clearly.]
Group findings by severity: 🔴 Critical | 🟡 Warning | 🔵 Suggestion
Each entry must include:
- **Location**: [File:line]
- **Issue**: [What is wrong?]
- **Why**: [Why it matters (performance, security, SOLID)?]
- **Fix**: [Corrected code snippet]
