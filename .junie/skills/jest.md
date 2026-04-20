---
name: jest
description: Jest unit testing for TS/JS, async tests, and snapshot policy
---

# Jest Skill

## Guidelines
- Prefer unit tests with mocked I/O; integration selectively.
- For async, use `async/await` and proper `done` usage avoided.
- Use snapshots sparingly; prefer explicit assertions.

## Checklist
- [ ] No real network/disk in unit tests
- [ ] Timers mocked where relevant
- [ ] Edge cases and error handling covered
