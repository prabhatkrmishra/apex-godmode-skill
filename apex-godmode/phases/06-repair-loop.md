# Phase 6 — Repair, Pivot, Regression

Turn each material finding into a bounded repair cycle.

## Repair cycle

1. capture evidence
2. identify root cause
3. choose repair strategy
4. implement smallest safe correction
5. rerun affected gate
6. rerun relevant regression checks
7. reassess the original finding

## Pivot

After two failed targeted repairs against the same root cause, consult `references/strategy-portfolio.md` and select a materially different strategy. Do not keep changing syntax around an unchanged architectural assumption.

## Regression lock

A repair is not accepted merely because the original check passes. Verify that adjacent behavior and prior passing gates remain intact.

## Stop conditions

Stop when bounded iteration is exhausted, progress stalls, authorization is missing, required infrastructure is unavailable, or continued editing becomes speculative.
