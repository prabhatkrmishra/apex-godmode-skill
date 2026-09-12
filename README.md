# Apex Godmode v6.4

One adaptive, evidence-driven engineering skill for Claude Code, Codex, OpenClaw, and Hermes.

## Design

Apex is intentionally packaged as **one skill** with one `SKILL.md` entrypoint and progressive disclosure through supporting files. Supporting phase, mode, reviewer, schema, reference, and script files are loaded progressively from the same skill directory.

```text
apex-godmode/
├── SKILL.md
├── modes/
├── phases/
├── reviewers/
├── references/
├── schemas/
└── scripts/
```

## Install

### Claude Code

Project-local:

```text
<project>/.claude/skills/apex-godmode/
```

User-wide:

```text
~/.claude/skills/apex-godmode/
```

Keep the entire `apex-godmode/` directory intact. Invoke with `/apex-godmode` in Claude Code. Skills are automatically discovered when the project/user skill source is enabled.

### Codex

Repository-local:

```text
<repo>/.agents/skills/apex-godmode/
```

User-wide:

```text
~/.agents/skills/apex-godmode/
```

The directory must contain `SKILL.md` at its root. Keep referenced subdirectories alongside it.

### OpenClaw

Workspace-local:

```text
<workspace>/skills/apex-godmode/
```

OpenClaw also recognizes project agent skills under:

```text
<workspace>/.agents/skills/apex-godmode/
```

For local/Git installs, preserve `SKILL.md` at the skill root. OpenClaw supports grouped skill layouts and loads supporting files from the skill directory.

### Hermes

User-wide:

```text
~/.hermes/skills/apex-godmode/
```

Hermes can also scan external skill directories; when using an external source, preserve the same directory structure and keep `SKILL.md` at the skill root. Hermes also documents `references/`, `templates/`, `scripts/`, and `assets/` as supported skill subdirectories.

## Usage

The public entrypoint is the single skill `apex-godmode`.

The router automatically selects execution depth from the task's scope, risk, coupling, and verification burden.

Internal policies:

- Godmode — standard high-rigor execution
- Godmode+ — broad/high-risk execution with decomposition, independent review, and runtime checks
- One-Shot — explicitly authorized autonomous execution with bounded repair loops
- Evolution — improvement of the skill/protocol itself

Users may explicitly request a policy, but ordinary usage only requires the main skill.

## Mandatory pre-implementation research

Before executable behavior is changed, Apex performs repository-wide stack detection (languages, runtimes, build/package managers, frameworks, application roles, material subsystems, test tooling, infrastructure, modules/workspaces) and detects actual language/framework/runtime/library versions (including explicit Spring Boot/Maven/Gradle fingerprints across multi-module repositories) and researches current anti-patterns and version-specific guidance on the web when the host provides web access.

Research is not accepted from search snippets alone. Material findings must be linked to the implementation plan and to a verification check. High-risk work requires stronger external-source coverage.

## Integrity

Apex treats evidence as primary. It is designed to detect common failure modes in autonomous agent workflows:

- claiming tests passed when they did not run
- modifying tests to make a failure disappear
- disabling diagnostics or security checks
- scoring stale artifacts
- benchmark leakage during self-improvement
- repeating the same failed repair strategy
- declaring success while a required check is blocked or unverified

Evolution and One-Shot use holdout/frozen evaluation concepts so increasing a self-score alone is not enough for promotion.

## Validation

The included shell scripts are helper checks, not substitutes for the host agent's own safety controls. Run them from the skill directory where appropriate.

## Official documentation used for this packaging

- Claude Code skill/plugin documentation: https://code.claude.com/docs/
- OpenAI Codex skills documentation: https://developers.openai.com/codex/skills/
- OpenClaw skills documentation: https://docs.openclaw.ai/skills
- Hermes skills documentation: https://hermes-agent.nousresearch.com/docs/user-guide/features/skills


## Competitive capabilities

Apex v6.3 includes task-type routing, adaptive depth, mandatory current-stack research, version-aware anti-pattern prevention, runtime verification, independent specialist review, evidence-integrity checks, bounded repair loops, strategy pivots, git/change safety, progress state, outcome feedback, and Evolution holdout/frozen-regression controls.

The design intentionally treats model self-scoring as secondary evidence. Objective commands, runtime observations, compiler/type/build results, and reproducible artifacts are preferred.

## Packaging references

The current official documentation describes Claude Code skills as directories containing `SKILL.md` with optional supporting resources; Claude can discover them automatically or invoke them as slash skills. OpenClaw describes the same `SKILL.md` directory model, including grouped layouts and referenced supporting files. Hermes documents `SKILL.md` plus `references/`, `scripts/`, and other supporting directories, with progressive disclosure.

Version: 6.3.0

## v6.3 additions

Apex v6.3 adds module-aware verification that does not trust a root test command as proof of child-module coverage, environment/reproducibility controls, generated-code controls, API compatibility review, UI accessibility review, explicit approval boundaries, resumable run state, workspace isolation, operations review, and change-scope review.


## v6 improvements

Apex v6 adds change-impact analysis, dependency-aware multi-module verification, stronger task routing based on blast radius rather than file count alone, and additional regression controls.


### v6.1 additions

Compatibility review, data-integrity review, test-hermeticity review, and release reversibility assessment are now first-class controls.


## License

MIT. See `LICENSE`.
