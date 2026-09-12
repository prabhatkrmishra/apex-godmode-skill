# Run State and Resume Safety

Long-running execution should be resumable without guessing what already happened.

## Checkpoint contents

Record only factual operational state:
- task identifier
- current phase
- selected mode
- baseline commit/diff identity when available
- completed gates
- failed/blocking gates
- strategy currently in use
- repair iteration count
- material external actions already performed
- artifacts/evidence locations

Do not store secrets, credentials, raw tokens, or private web session data.

## Resume protocol

On resume:
1. inspect the current repository state
2. compare it to the last checkpoint
3. identify changes made since the checkpoint
4. mark uncertain actions as unknown rather than complete
5. rerun narrow idempotent verification before continuing
6. never replay an externally visible/destructive action until its prior execution state is established

## Abort protocol

On unrecoverable failure, leave the workspace in a known state where practical and record what remains incomplete. A stopped run is not a failed implementation unless the evidence establishes implementation failure.
