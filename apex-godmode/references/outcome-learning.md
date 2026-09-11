# Outcome Learning

Internal quality scores are leading indicators. Real outcomes are the external signal.

## Capture

When a user provides a post-delivery verdict, record:
- task category
- selected mode
- internal gate result
- shipped-as-is / edited / rejected
- concise failure or success reason

Do not store secrets, credentials, private identifiers, or repository contents unless the user explicitly asks for persistent storage.

## Use

Outcome data may influence future benchmark design and reviewer emphasis. It must not be used to retroactively falsify a historical run.
