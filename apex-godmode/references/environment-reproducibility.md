# Environment and Reproducibility

A green result is trustworthy only when the environment is sufficiently identified and repeatable for the claim being made.

Record material versions when available:
- language/runtime
- build/package manager
- framework/runtime
- test runner
- OS/container/toolchain constraints for unusual failures

Prefer repository-pinned wrappers and lockfiles over globally installed tools. Use project-local package managers and wrappers when available.

When a check depends on external services, credentials, network, current time, randomness, or machine-specific state:
- identify the dependency
- isolate it where practical
- distinguish environment failure from product failure
- do not convert inability to reproduce into PASS

Avoid changing global machine state merely to make a test pass. Prefer temporary, scoped, reversible environment changes.

For flaky tests, distinguish:
- deterministic failure
- deterministic pass
- flaky/inconclusive
- environment/tooling failure

A flaky or inconclusive result is not a PASS without additional evidence establishing the intended behavior.
