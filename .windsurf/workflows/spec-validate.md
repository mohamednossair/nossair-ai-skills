---
description: Validate SDD artifacts for consistency
---

**Usage**: `/spec-validate`

1. Read all `.spec/` artifacts: `constitution.md`, `spec.md`, `plan.md`, `tasks/*.md`.
2. Check consistency, completeness, and token efficiency.
3. Flag: prose paragraphs, duplicate info, vague constraints, missing sections.
4. Output: [Critical] | [Warning] | [Suggestion] with fix for each.
