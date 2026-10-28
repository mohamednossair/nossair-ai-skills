---
name: accessibility
description: Accessibility (a11y) standards for Angular templates and TypeScript — semantic HTML, keyboard navigation, ARIA, focus management
---

# Accessibility Skill

Use this skill when building or reviewing user-facing UI. It defines the project's accessibility standards for Angular templates and TypeScript.

## When to Use
- Creating or reviewing Angular components, templates, or styles.
- Building forms, dialogs, tables, navigation, or custom interactive widgets.
- Reviewing UI for keyboard or screen-reader usability.

## Key Principles
- **Semantic HTML first**: prefer native elements (`button`, `a`, `label`, `table`) over ARIA-recreated ones.
- **Keyboard complete**: every interactive element is reachable and operable by keyboard.
- **Visible focus**: never remove focus outlines without an equivalent alternative; logical focus order.
- **Labels for everything**: every input has a programmatic label; icon-only buttons have accessible names.

## Guidelines

### Semantic HTML
- `<button>` for actions, `<a href>` for navigation — never clickable `<div>`/`<span>`.
- One `<h1>` per page; heading hierarchy without skipped levels.
- `<label for>` (or wrapping label) for every input; `fieldset`/`legend` for grouped controls.
- Landmarks: `header`, `nav`, `main`, `footer`; include a skip-to-content link.

### ARIA (only when semantics are not enough)
- `aria-label`/`aria-labelledby` for icon-only buttons and custom controls.
- `aria-expanded`/`aria-controls` for disclosure widgets; `aria-live="polite"` for async status updates.
- Use `role` only when no native equivalent exists; never `role="presentation"` on interactive elements.
- Do not duplicate native semantics (no redundant `aria-label` on a button that already has text).

### Keyboard & Focus
- Full keyboard operability: Tab order matches visual order; Enter/Space activate buttons.
- Dialogs: move focus in on open, trap focus while open, restore focus to the trigger on close; Escape closes.
- Use `:focus-visible` styles; never `tabindex` > 0; `tabindex="0"` only for custom widgets.

### Forms
- Errors announced: `aria-describedby` linking the input to its error text; `aria-invalid` on failure.
- Never rely on color alone — pair errors with text and an icon.
- `autocomplete` attributes for common fields; clear required indicators.

### Visual
- Contrast: text 4.5:1 (3:1 for large text); UI components 3:1.
- Content reflows at 320px width without horizontal scrolling; safe at 200% zoom.
- Respect `prefers-reduced-motion` for animations and transitions.

## Checklist
- [ ] Interactive elements are native (or have correct role)?
- [ ] Every input has a programmatic label?
- [ ] Icon-only buttons have accessible names?
- [ ] Full keyboard operability with logical Tab order?
- [ ] Focus visible; dialogs trap and restore focus?
- [ ] Heading hierarchy without skips; landmarks used?
- [ ] Errors announced and not color-only?
- [ ] Contrast meets 4.5:1 (3:1 for large text)?
- [ ] Async updates use `aria-live`; animations respect `prefers-reduced-motion`?
