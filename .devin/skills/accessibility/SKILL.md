---
name: accessibility
description: Accessibility (a11y) standards for Angular templates and TypeScript — semantic HTML, keyboard navigation, ARIA, focus management
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Apply the project's accessibility standards when creating or reviewing Angular components, templates, forms, dialogs, tables, or custom widgets.

1. Read the detailed skill at `.junie/skills/accessibility/SKILL.md` and follow it.
2. Combine with the `angular` skill for component and template work.
3. When reviewing, group findings by [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix. Flag as Critical: missing labels on inputs, keyboard-inaccessible controls, focus removed without alternative, color-only error indication.
