# Anti-Gaming Reviewer

Inspect whether the run could have passed by weakening its own evaluation.

Check:
- test selection and exclusions
- changed assertions/fixtures
- disabled diagnostics
- altered thresholds
- swallowed errors
- stale/generated evidence
- benchmark leakage
- missing changed files from review
- claims unsupported by executed commands

Return findings with severity, evidence, affected artifact, and remediation.
