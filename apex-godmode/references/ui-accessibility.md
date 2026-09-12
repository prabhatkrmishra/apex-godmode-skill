# UI, Accessibility, and User-Visible Behavior

For UI/frontend changes, verify the actual user-observable state, not only rendered source.

Assess when applicable:
- keyboard navigation and focus behavior
- accessible names/roles/states
- semantic HTML or framework-native accessibility patterns
- contrast and reduced-motion concerns
- loading, empty, error, disabled, and retry states
- responsive/layout behavior
- async race conditions and stale data presentation
- browser/runtime console errors

Use current framework accessibility guidance discovered during the research gate. Prefer automated accessibility checks where the repository supports them, then perform targeted manual/runtime verification for behavior automation cannot establish.
