---
description: Generate domain-specific requirement-quality checklists (unit tests for English)
---
Act as a QA Lead. Create a review checklist from requirements.

> **Core concept**: Checklists are **unit tests for requirements writing** — they validate the quality, clarity, and completeness of requirements, NOT the implementation.

## Actions
1. Derive up to 3 clarifying questions from the user's phrasing + spec/plan context to calibrate scope, depth, and risk emphasis.
2. Create `checklists/<domain>.md` under the feature directory (append if it exists). Use globally incrementing IDs: `CHK001`, `CHK002`, etc.
3. Write checklist items that test the **requirements themselves** for:
   - **Completeness** — Are all necessary requirements present?
   - **Clarity** — Are they unambiguous and specific?
   - **Consistency** — Do they align without conflicts?
   - **Measurability** — Can they be objectively verified?
   - **Coverage** — Are all scenarios/edge cases addressed?
4. Use question format, not verification format:
   - ✅ CORRECT: `"Are error response formats specified for all failure scenarios? [Completeness]`"
   - ❌ WRONG: `"Verify the API returns 400 on bad input"`
5. Tag each item with its quality dimension and traceability reference (e.g., `[Clarity, Spec §FR-2]` or `[Gap]`).
6. Link to relevant skills or standards where helpful.
7. Keep to one line per check; avoid paragraphs. Soft cap at ~40 items; merge near-duplicates.

## Output Format
```markdown
# Review Checklist

## API
- [ ] [Requirement] ([AC-1])

## UI
- [ ] [Requirement] ([AC-2])

## Security
- [ ] [Requirement] ([AC-3])

## Performance
- [ ] [Requirement]

## Data
- [ ] [Requirement]

## Testing
- [ ] [Requirement]
```
