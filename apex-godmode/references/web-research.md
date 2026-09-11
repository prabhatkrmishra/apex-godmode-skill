# Web Research Playbook

Use current external research to prevent version drift and implementation mistakes. This reference complements `anti-pattern-research.md` rather than replacing it.

## Source selection

Start with primary sources for the exact component:
- language official docs / standard library docs
- framework docs
- library docs
- release/migration/changelog pages
- official security advisories / CVE databases when security is involved
- standards/specifications/RFCs

Use reputable secondary sources only when primary sources do not explain a practical edge case. Do not let a blog override an official deprecation/security/migration statement without explicit evidence.

## Query construction

Build queries from:
`component + exact version + subsystem/feature + question`

Useful forms:
- `<framework> <version> <feature> recommended pattern`
- `<framework> <version> <feature> anti-pattern`
- `<library> <version> breaking change <feature>`
- `<runtime> <version> cancellation lifecycle <subsystem>`
- `<component> security advisory <affected feature>`
- `<language> <version> deprecated <API>`

Also search the official documentation domain directly when practical.

## Freshness

For rapidly changing frameworks/libraries, prefer current docs and release notes over old tutorials. When guidance changed across versions, record the version boundary explicitly.

## Research quality test

A source is strong when it directly establishes one or more of:
- the API/pattern is recommended
- the API/pattern is deprecated or unsafe
- a known failure/security mode exists
- a compatibility constraint exists
- a preferred framework-native alternative exists

A source is weak when it only asserts a preference without mechanism or version context.

## Evidence extraction

For each material source capture:
- title
- publisher/owner
- URL
- applicable version
- relevant section/topic
- claim
- implementation implication
- verification implication

Do not copy large source passages. Store concise paraphrases.

## Research stopping rule

Stop when the material implementation questions are answered, conflicting guidance is reconciled, and additional searching is unlikely to change the decision. Avoid research theater.
