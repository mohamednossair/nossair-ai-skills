---
description: Review code using relevant tech skill and guidelines
---

**Usage**: `/review file="path/to/file"`

1. Identify the technology from the file extension.
2. Apply coding standards from `coding-standards.md` and `tech-stack.md`.
3. Analyze: correctness, security, performance, readability, SOLID/DRY.
4. Output findings grouped by: [Critical] | [Warning] | [Suggestion]
   - **Location**: [File:line]
   - **Issue**: [What is wrong]
   - **Why**: [Impact]
   - **Fix**: [Corrected code]
