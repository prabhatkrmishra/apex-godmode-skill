# Evaluation Integrity and Anti-Gaming

The workflow must be difficult to game. A high score is invalid if evidence was fabricated, skipped, weakened, or inferred without execution.

## Evidence rules

1. A command that was not executed is not a passed check.
2. A test file that exists is not proof that its test ran.
3. A changed line is not proof that the intended behavior changed correctly.
4. A self-score cannot override failing deterministic evidence.
5. Reviewers must not score from the summary alone when source inspection is feasible.
6. The final gate must reference concrete artifacts: commands, outputs, files, runtime observations, or source links.

## Anti-gaming checks

Before accepting a passing gate, check for:
- skipped tests or filtered test suites
- modified assertions that merely make tests pass
- coverage exclusions added during the task
- disabled lint/type/security checks
- swallowed exceptions or downgraded log levels hiding failure
- benchmark inputs simplified to avoid the defect
- generated/placeholder evidence with no corresponding execution
- stale caches or old artifacts mistaken for current output
- new files not included in the review/change inventory

## Holdout evaluation

For Evolution and One-Shot, maintain at least one task/benchmark not shown to the improvement loop. Do not tune instructions directly against every benchmark.

When a benchmark is modified, keep the prior version as a frozen regression case unless intentionally retired with evidence.

## Independent assessment

Where possible, separate generation from evaluation context. The evaluator should receive:
- task statement
- expected acceptance criteria
- relevant changed artifacts
- raw verification evidence

Do not give the evaluator the candidate's self-justifying narrative before assessment.

## Outcome feedback

After a shipped result, optionally record one of:
- shipped-as-is
- edited-by-human
- rejected

Use real user outcome as a separate signal from internal score. Never rewrite prior scores to match outcome.
