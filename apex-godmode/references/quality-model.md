# Quality and Evidence Model

## Evidence precedence
1. deterministic behavioral/runtime evidence
2. compiler/type/build evidence
3. static/security tooling
4. integration/e2e evidence
5. current official guidance
6. independent reviewer findings
7. model self-assessment

Self-score is a summary, never proof.

## Dimensions
- correctness
- test adequacy
- compatibility/integration
- security
- performance/resource behavior
- architecture/maintainability
- observability/recovery where relevant
- anti-pattern avoidance

## Severity
- P0: catastrophic/security-critical/data-loss/blocking correctness
- P1: major regression/high-risk security/compatibility/material contract break
- P2: meaningful bounded defect
- P3: non-blocking quality issue

P0/P1 block completion. P2 should normally be fixed when local and safe. P3 may be documented.

## Scoring guidance
Use 0–1 values only as prioritization signals:
- 1.00 = strong evidence of satisfaction
- 0.85 = acceptable with minor residual risk
- below 0.85 = weak dimension requiring more work unless evidence shows it is N/A

Never turn a numeric threshold into permission to ignore a blocking defect.
