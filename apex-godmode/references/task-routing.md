# Task Routing Matrix

Classify the task before choosing execution depth. Do not route solely from words like "simple", "quick", or "refactor"; route from observed scope, coupling, risk, and verification burden.

## Task classes

| Class | Signals | Default depth | Required reviewers |
|---|---|---|---|
| bugfix | observed failure, regression, incorrect behavior | Godmode | correctness + testing + anti-pattern |
| feature | new behavior, new endpoint/UI/workflow | Godmode | correctness + testing + integration + anti-pattern |
| refactor | structure changes with intended behavior preserved | Godmode | architecture + testing + integration |
| migration | schema/API/runtime/framework/dependency migration | Godmode+ | architecture + integration + security + testing |
| security | auth, secrets, input handling, sandboxing, privilege | Godmode+ | security + correctness + anti-pattern |
| performance | latency, throughput, memory, CPU, DB/network efficiency | Godmode+ | performance + correctness + testing |
| integration | external API/service, queue, storage, deployment boundary | Godmode+ | integration + security + testing |
| audit | inspect without intended functional change | Godmode+ | security + architecture + anti-pattern + testing |
| writing/analysis | non-code artifact | Godmode or One-Shot only if explicitly requested | correctness |
| skill/system change | skill, evaluator, router, runner, benchmark changes | Evolution | architecture + testing + anti-gaming |

## Escalation signals

Escalate from Godmode to Godmode+ when any two are true, or immediately for critical security/data-integrity risk:
- more than one independently deployable component
- shared/public contract changes
- database or data migration
- authentication/authorization boundary
- concurrency/cancellation/lifecycle semantics
- infrastructure/deployment configuration
- cross-repository or external-service coupling
- runtime behavior must be proven end-to-end
- rollback is materially non-trivial
- more than roughly 5 related files after recon

Escalate to One-Shot only when the user explicitly authorizes autonomous completion. One-Shot is an execution policy, not a quality exemption.

## Routing output

Record:
- task_class
- observed_scope
- risk_level: low | medium | high | critical
- verification_burden: low | medium | high
- selected_mode
- escalation_reason
- selected_reviewers
