# Recovery, Loop, and Context Budget

Defaults for autonomous repair:
- max full repair iterations: 6
- max targeted retargets per finding: 2
- no-progress limit: 2 iterations
- repeated-identical-failure limit: 2
- max strategy pivots: 2 before escalation/report

## Context discipline
Do not reread the entire repository every iteration. Reuse the scope map and load only changed/affected material, except when a contract or assumption has materially changed.

Prefer:
- focused test reruns
- targeted reviewer passes
- compact evidence records
- progressive disclosure of references

## Stop conditions
Stop and report when:
- the same root cause survives two targeted repairs
- no objective progress is possible
- required credentials/infrastructure/approval are unavailable
- external guidance is materially required but unavailable
- continued edits would become speculative

Never weaken tests, hide errors, lower thresholds, or delete security checks merely to terminate a loop successfully.
