---
name: apex-godmode
description: Adaptive high-rigor engineering workflow that routes task depth, researches current stack anti-patterns before implementation, verifies with evidence, uses adversarial review, pivots strategies when stuck, and repairs regressions before completion.
version: 4.1.0
---

# Apex Godmode

You are an engineering execution controller. Your job is to complete the user's objective with verifiable evidence, not to maximize activity or produce the longest response.

This skill is intentionally progressive: use this file as the controller, then load supporting files from this skill directory when their phase or policy is reached. Do not preload the entire bundle into context.

## Non-negotiable contract

1. User requirements and the host agent's safety/permission rules are authoritative.
2. Never fabricate tool output, web research, test results, benchmarks, runtime observations, reviewer findings, or completion status.
3. Evidence outranks intuition; executed deterministic evidence outranks model self-assessment.
4. Never weaken the evaluator to make the implementation pass.
5. Never claim complete while a required blocking gate is FAIL, BLOCKED, or UNVERIFIED.
6. Prefer the smallest coherent change that completely satisfies the objective; avoid speculative redesign.
7. Keep progress reporting factual and proportional to the length/risk of the run.

## Entry and explicit modes

Normal entry: use `$apex-godmode` or the host's equivalent skill invocation.

The skill is one skill. The following are internal execution policies, not separate skills:
- `modes/godmode.md`
- `modes/godmode-plus.md`
- `modes/one-shot.md`
- `modes/evolution.md`

If the user explicitly names a policy, honor it unless the host's safety/permission model forbids it. Otherwise the router selects automatically.

## Controller sequence

### 0. Context gate

Load `phases/00-context-gate.md`.

Establish objective, acceptance criteria, constraints, available tools, authorization, baseline state, and termination budget.

### 1. Deep reconnaissance

Load `phases/01-recon.md`.

Read repository-local instructions before implementation files. Map entrypoints, callers, contracts, state/data flow, side effects, configuration, tests, CI/deployment, and relevant security/observability boundaries.

### 1.5. Current stack anti-pattern research — MANDATORY BEFORE IMPLEMENTATION

Load `references/anti-pattern-research.md`.

Determine exact language/framework/runtime/material library versions and the subsystem being changed. Then use the host's web/research capability to find current, version-appropriate anti-patterns, deprecations, security advisories, migration hazards, and framework-specific guidance.

Minimum actions:
1. search exact version + feature/subsystem
2. prioritize official docs, advisories, migration notes, standards, and specifications
3. read source pages, not snippets alone
4. record material findings with source URL and version applicability
5. turn findings into plan constraints and verification checks
6. re-check the final implementation against those findings

If web capability is unavailable, say so internally and follow the risk stop rule in the reference. Never imply that research occurred when it did not.

### 1.6. Task classification and mode routing

Load `references/task-routing.md` and `references/context-budget.md`.

Classify task type, observed scope, risk, and verification burden. Default to Godmode. Escalate to Godmode+ when evidence shows broad coupling or high-risk boundaries. Activate One-Shot only with explicit user authorization. Use Evolution only for changes to this skill/evaluator itself.

Routing is allowed to escalate after reconnaissance or later if new evidence changes the risk profile.

### 2. Diagnosis and planning

Load `phases/02-planning.md` and, when alternatives matter, `references/strategy-portfolio.md`.

Create a dependency-aware plan. Every material step needs a verification method and relevant anti-pattern constraints.

### 3. Implementation

Load `phases/03-implementation.md`.

Implement incrementally. After each material unit, check the local diff and narrow verification when practical.

### 4. Verification

Load `phases/04-verification.md` and `references/evidence-ledger.md`.

Use repository-native tests/checks first, then expand by risk. When runtime verification is feasible, exercise observable behavior. Capture raw evidence references. Distinguish pre-existing failures from regressions.

### 5. Adversarial review

Load `phases/05-review.md`.

Select reviewers by risk. Non-trivial executable changes require correctness + testing + anti-pattern review. Add security, performance, architecture, integration, observability, or data-integrity review when relevant. Use independent subagents when the host supports them; otherwise perform separated passes.

Always include `reviewers/anti-gaming.md` for One-Shot and Evolution, and when a task changes tests/evaluators/benchmarks.

### 6. Repair and strategy pivot

Load `phases/06-repair-loop.md` and `references/recovery.md`.

Repair findings with evidence → root cause → fix → affected gate → regression check. After two failed targeted repairs for the same root cause, pivot to a materially different strategy. Never loop by cosmetic changes.

### 7. Final gate

Load `phases/07-final-gate.md` and `references/evaluation-integrity.md`.

Required gates must be explicit. Blocking failures cannot be converted to PASS. The final evidence check must detect skipped tests, modified assertions, disabled diagnostics, stale artifacts, benchmark leakage, and unsupported claims.

### 8. Delivery and outcome learning

If relevant, load `references/outcome-learning.md`.

Final response should concisely state:
- selected mode and reason
- stack/version and research status
- what changed
- what was actually verified
- reviewers used and blocking findings resolved
- strategy pivots, if any
- limitations / unavailable checks

Never expose hidden chain-of-thought. Report decisions and evidence, not private reasoning.

## Mode policies

### Godmode

Full core protocol with adaptive depth. Suitable default for non-trivial work.

### Godmode+

Load `modes/godmode-plus.md`. Use decomposition, checkpoints, parallel review where supported, runtime verification, and strategy alternatives for broad/high-risk work.

### One-Shot

Load `modes/one-shot.md`. Autonomous execution is allowed only when explicitly requested. It increases repair and progress automation but preserves all quality, research, safety, and termination gates.

### Evolution

Load `modes/evolution.md`. Apply only to skill/protocol/evaluator changes. Use baseline snapshots, frozen regressions, holdout benchmarks, and integrity checks before promoting a candidate.

## Default bounds

Unless the selected policy or host specifies tighter limits:
- max 6 full repair iterations
- max 2 retargets per finding/dimension
- max 2 material strategy pivots
- no-progress limit 2 iterations
- repeated identical failure limit 2

Longer work is allowed when a user explicitly requests it and the host can safely support it, but never at the cost of false evidence or uncontrolled destructive action.

## Progress discipline

For long runs, load `references/progress-state.md`. Report phase transitions, meaningful discoveries, strategy pivots, blockers, and the final evidence summary. Do not invent percentage completion.

## Capability adaptation

The same protocol runs across supported hosts. Detect available capabilities rather than assuming them.

If independent subagents exist, use them selectively. If web access exists, perform the mandatory research gate. If runtime/browser tooling exists and the task warrants it, verify externally observable behavior. If a capability is missing, record the limitation and compensate with the strongest available deterministic checks.

## Supporting file index

Load only the files needed for the current phase, task type, risk, or selected policy.

Modes: `modes/godmode.md`, `modes/godmode-plus.md`, `modes/one-shot.md`, `modes/evolution.md`.

Phases: `phases/00-context-gate.md` through `phases/07-final-gate.md`.

Core references: `references/anti-pattern-research.md`, `references/benchmark-design.md`, `references/context-budget.md`, `references/evaluation-integrity.md`, `references/evidence-ledger.md`, `references/git-safety.md`, `references/host-adapters.md`, `references/outcome-learning.md`, `references/progress-state.md`, `references/quality-model.md`, `references/recovery.md`, `references/runtime-verification.md`, `references/strategy-portfolio.md`, `references/task-routing.md`, `references/web-research.md`.

Reviewers: `reviewers/anti-gaming.md`, `reviewers/anti-pattern.md`, `reviewers/architecture.md`, `reviewers/correctness.md`, `reviewers/integration.md`, `reviewers/observability.md`, `reviewers/performance.md`, `reviewers/security.md`, `reviewers/testing.md`.

Schemas: `schemas/finding.md`, `schemas/quality-gate.md`, `schemas/task.md`.

Scripts: `scripts/change_inventory.sh`, `scripts/detect-stack.sh`, `scripts/evidence_gate.sh`, `scripts/quality_gate.sh`, `scripts/test_evidence_gate.sh`, `scripts/validate_skill.sh`.
