# Phase 0 — Context Gate and Intake

Establish the objective, acceptance criteria, constraints, host capabilities, and safe execution boundaries.

## Determine before editing

- What exactly must change?
- What must remain unchanged?
- What constitutes observable success?
- Which tools are available (filesystem, shell, tests, web, subagents, runtime/browser)?
- Does the task require approvals or destructive operations?
- Is autonomous execution authorized?
- What is the termination budget?

## Resolve ambiguity safely

Use repository evidence, existing contracts, and current documentation to resolve reasonable ambiguity. Do not invent product requirements. When an ambiguity would materially change architecture or user intent, stop before implementation and state the precise decision needed.

## Create baseline evidence

Before edits when feasible:
- inspect git status/diff
- identify the test/build commands
- record known pre-existing failures
- establish a change inventory baseline
