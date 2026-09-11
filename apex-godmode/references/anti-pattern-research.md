# Current Stack Anti-Pattern Research Protocol

Research is a pre-implementation control. It exists to prevent the agent from reproducing known bad practice for the exact versions in the repository.

## Gate A — identify the stack

Before web research, inspect manifests, lockfiles, runtime/toolchain files, build config, and source imports. Record exact versions when discoverable. If a package is transitive but material, identify its resolved version from the lockfile.

Minimum stack record:
- language + version/toolchain
- framework + version
- runtime + version
- material libraries + resolved versions
- subsystem being changed

## Gate B — identify research questions

Generate focused questions from the change, such as:
- What APIs/patterns are deprecated or replaced in this version?
- What lifecycle/cleanup rules are framework-specific?
- What concurrency/cancellation traps exist?
- What security advisories or unsafe defaults apply?
- What migration constraints or compatibility rules apply?
- Which framework conventions are intentionally preferred over generic language patterns?

## Gate C — search current external guidance

Use the host's web/research capability before implementation whenever available. Search exact versions and the affected subsystem. Prefer:
1. official documentation
2. official security advisories
3. official release/migration notes
4. standards/RFC/specification documents
5. reputable technical references

Read the source pages. Search snippets are discovery aids, not evidence.

## Gate D — source verification

For each material claim, confirm:
- source URL
- page/document title
- publication/version applicability
- exact mechanism or recommendation
- why it applies to this code change

Do not record a generic recommendation as a stack-specific rule unless the source supports that mapping.

## Gate E — convert findings into implementation constraints

Every material anti-pattern finding must become at least one of:
- prevention rule in the plan
- code-level design constraint
- test/verification check
- reviewer instruction

Example:
`React 19 + effect lifecycle -> avoid effect for derived state` is incomplete.
Convert it to: `Do not mirror derived state through an effect; compute it during render unless an external synchronization side effect is required. Verify no redundant state/effect cycle was introduced.`

## Minimum research depth

Low-risk executable change: 2 quality sources when web access exists, including 1 primary source.
High-risk/security/migration change: 3+ quality sources when available, with primary security or migration guidance where relevant.

Do not pad the research with unrelated links.

## Research ledger

| Finding | Source | Version | Applicability | Exposure | Prevention | Verification |
|---|---|---|---|---|---|---|

## Re-check triggers

Repeat the research gate if:
- the implementation changes the affected framework/library version
- a new subsystem becomes in scope
- a reviewer finds a previously unknown framework-specific hazard
- the original sources are superseded during the task

## Web unavailable

Never claim that current web research was performed when it was not. When web access is unavailable, do not implement executable changes unless the task is demonstrably low-risk and the missing research cannot materially affect the implementation. For material framework or language guidance, block implementation rather than fabricating confidence.
