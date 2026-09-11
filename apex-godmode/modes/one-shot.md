# One-Shot Execution Policy

One-Shot means autonomous completion with internal progress, repair, and verification. It does not mean infinite work or removal of safety boundaries.

## Activation

Activate only when the user explicitly requests autonomous/one-shot/full-send execution or explicitly invokes this mode.

## Loop

1. run the full applicable execution protocol
2. score required dimensions from evidence
3. identify weak dimensions
4. re-run only the phases necessary to repair them
5. re-score
6. perform final blind/evidence-integrity review
7. deliver only when all blocking gates pass

## Bounds

Default maximums:
- 6 full repair iterations
- 2 retargets per finding/dimension
- 2 material strategy pivots
- stop on no-progress, repeated identical failure, missing authorization, or required unavailable infrastructure

Never claim "perfect". Report residual risk and actual evidence.
