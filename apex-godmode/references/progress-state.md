# Progress and State Protocol

Expose meaningful progress without flooding the user.

## State record

Maintain:
- run_id
- phase
- task_class
- selected_mode
- phase_status
- current objective
- files in scope
- last completed gate
- active blockers
- iteration count
- strategy history
- evidence references

## Phase status values

`PENDING -> ACTIVE -> PASSED | FAILED | BLOCKED | SKIPPED`

A skipped phase must carry a reason and cannot be silently treated as passed.

## User progress

For long runs, report only:
1. phase transition
2. meaningful discovery/risk
3. strategy pivot
4. blocker requiring user action
5. completion with evidence summary

Never report fabricated percentages. If exact progress cannot be measured, report the current phase and completed gates instead.
