# Strategy Portfolio and Pivoting

A strategy is the implementation approach, not a minor syntax variation.

## Candidate strategies

For material tasks, enumerate 2–3 plausible approaches before committing when the choice has architectural consequences. Record:
- correctness model
- complexity
- compatibility
- performance
- operational risk
- reversibility

## Selection

Prefer the strategy with the best overall risk-adjusted fit to the repository, not the shortest code.

## Pivot rule

If two targeted repairs fail against the same root cause, do not issue a third equivalent patch. Compare the failure evidence with the strategy assumptions and choose a materially different approach.

A material pivot changes at least one of:
- architecture/data flow
- algorithm
- API boundary
- concurrency model
- dependency choice
- state-management strategy

## Preserve failed-strategy evidence

Keep a compact record of what was tried and why it failed. Do not repeatedly reopen the same dead path.
