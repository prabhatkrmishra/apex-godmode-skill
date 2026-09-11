# Benchmark and Evaluation Design

Benchmarks are for measuring the workflow, not flattering it.

## Suite composition

For Evolution, maintain a diverse frozen suite across:
- bugfix
- feature
- refactor
- integration
- migration
- security/audit
- at least one adversarial or ambiguous task

Use a separate holdout set that is not used to tune the protocol.

## Benchmark integrity

A benchmark must have:
- a real artifact/repository state
- explicit acceptance criteria
- deterministic checks where possible
- an execution log
- a reproducible baseline

Reject benchmarks that can be passed by generating a superficial stub.

## Promotion rule

A candidate protocol is promoted only when it:
- improves the target weakness
- preserves frozen regression performance within declared tolerance
- does not weaken evidence integrity
- passes holdout checks better than or equal to baseline

A higher self-score alone is never sufficient.
