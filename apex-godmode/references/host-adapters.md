# Host Capability Adapters

Apex is one skill intended to work across Claude Code, Codex, OpenClaw, and Hermes. Detect capabilities instead of assuming command names or tool schemas.

## Common capabilities

- read/search files
- edit/write files
- shell/terminal execution
- web/research access
- isolated subagents
- runtime/browser verification
- git/diff inspection

## Claude Code

Prefer skill-relative references as ordinary files. When useful, use independent subagents for isolated review and custom agents where the host configuration provides them. Claude Code skills are discovered from `.claude/skills/<name>/SKILL.md`; the skill may include supporting resources.

## Codex

Use the repository's discovered instructions and available tools. Keep the workflow portable: do not require Claude-specific commands, hooks, or tool names. Shared agent skills are typically discovered from `.agents/skills/<name>/SKILL.md`.

## OpenClaw

Use the skill root and `{baseDir}` when the host expands it. Do not assume OpenClaw-specific dispatch unless detected. Keep supporting references/scripts under the skill directory.

## Hermes

Use the skill root supplied by the host. `${HERMES_SKILL_DIR}` may be available for bundled scripts. Do not assume inline shell is enabled; prefer explicit terminal execution through the host.

## Adaptation rule

When a capability is unavailable, substitute the strongest available mechanism and record the limitation. Never simulate a tool result.
