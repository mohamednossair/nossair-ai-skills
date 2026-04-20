---
name: python
description: Typing, packaging, logging, and performance hygiene
---

# Python Skill

## References
- `.windsurf/memories/coding-standards.md`

## Guidelines
- Use typing (`from __future__ import annotations` if 3.10-).
- Structure packages with clear __init__ APIs; avoid giant modules.
- Logging via stdlib logging; no prints in libraries.
- Watch hotspots: comprehensions, generators, avoid quadratic patterns.

## Checklist
- [ ] Type hints for public APIs
- [ ] Exceptions precise; no blanket except
- [ ] Unit tests with pytest or unittest
- [ ] Virtual env and pinned deps
