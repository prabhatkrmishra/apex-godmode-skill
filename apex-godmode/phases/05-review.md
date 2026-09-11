# Phase 5 — Adversarial Review

Review the completed change against the acceptance criteria, repository architecture, current external guidance, and actual verification evidence.

## Review order

1. correctness: does behavior match the objective?
2. testing: are meaningful failure modes represented and executed?
3. anti-pattern: did implementation violate researched stack guidance?
4. integration: did callers/contracts/runtime boundaries remain valid?
5. security: are trust boundaries and sensitive flows safe?
6. performance: did cost/resource behavior regress?
7. architecture: is the change coherent with existing boundaries?
8. observability/recovery when relevant
9. anti-gaming: is the evidence itself trustworthy?

## Finding standard

A finding must state:
- severity
- exact evidence
- why it violates acceptance criteria or a known constraint
- smallest safe remediation
- verification after remediation

Do not create speculative findings without evidence.
