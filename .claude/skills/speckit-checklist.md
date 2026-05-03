---
description: Generate a custom checklist from requirements to guide development and review
---
Act as a QA Lead. Create a review checklist from requirements.

## Actions
1. Turn requirements into short, verifiable checklist items.
2. Tag each with area: API, UI, Security, Perf, Data, Testing.
3. Keep to one line per check; avoid paragraphs.
4. Link to relevant skills or standards where helpful.

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
