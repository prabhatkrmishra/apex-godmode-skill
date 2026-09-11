# Phase 4 — Verification

Verification is evidence collection, not a ritual.

## Order

1. focused tests for changed behavior
2. targeted type/lint/static checks
3. regression tests
4. build/package checks
5. integration/e2e/runtime checks proportional to risk
6. security/performance checks where relevant

Prefer repository-native commands discovered from manifests/CI docs. Do not invent a command and then treat its absence as a product failure.

## Runtime verification

When a running app/service exists and the host provides the necessary tools, exercise the observable path that the user actually cares about. Record what was executed and what was observed.

## Failure classification

Every failure is:
- pre-existing
- introduced by this change
- environment/tooling related
- inconclusive

Inconclusive evidence cannot be reported as PASS.
