# Evolution Execution Policy

Evolution improves the skill/protocol itself rather than solving an ordinary repository task.

## Safety model

Never mutate the only canonical copy in place without a recoverable snapshot. Prefer:
- baseline snapshot
- candidate variant
- frozen benchmark set
- holdout benchmark set
- isolated evaluation run
- promotion only after evidence

## Modes

### Evolve
Improve the current candidate while preserving a recoverable baseline.

### Mutate
Fork a candidate variant, change a bounded set of instructions/parameters, then evaluate.

### Splice
Combine complementary parts of two known candidates, then evaluate from a fresh baseline.

## Evaluation

Every candidate must be evaluated against:
- frozen regressions
- diverse task types
- at least one holdout task not optimized against
- evidence-integrity checks

Never accept a candidate only because its self-score increased. It must not degrade frozen tasks or integrity gates beyond the declared tolerance.
