# Test Hermeticity Reviewer

Check whether verification results are trustworthy and reproducible.

Look for:
- network-dependent tests without explicit controls
- reliance on host-global state or credentials
- time/randomness without deterministic controls
- shared mutable fixtures
- order dependence
- test pollution and leaked processes
- stale generated artifacts
- disabled/reduced coverage
- hidden retries that mask intermittent failures
- environment-specific behavior not recorded in evidence

A passing suite that cannot be reasonably reproduced is evidence with reduced confidence, not unconditional PASS.
