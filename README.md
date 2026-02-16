# aeg

Elixir umbrella for agent runtime with first-class support for:
- guardrails (`aeg_guard`)
- evals (`aeg_eval`)
- context/memory (`aeg_memory`)
- proactive agents (`aeg_proactive`)
- persistence (`aeg_persistence`)
- world-model loops (`aeg_world`)
- provider adapters (`aeg_adapters_*`)

License: Apache-2.0

## Why aeg

`aeg` is designed for teams building production agents in Elixir/OTP that need:
- safe execution (`:allow | :intercept | :block`)
- decomposition of generic tasks/goals
- human-in-the-loop intervention when intent is ambiguous
- proactive agent messaging
- world-model action loops (act -> observe -> update)

## Repository Structure

```text
apps/
  aeg/                       # Public facade
  aeg_runtime/               # Core runtime pipeline and planner
  aeg_guard/                 # Guardrails and policies
  aeg_eval/                  # Evaluation cases/results/gates
  aeg_memory/                # Context + memory contracts and stores
  aeg_persistence/           # Event persistence contracts and repos
  aeg_proactive/             # Proactive policy contracts and defaults
  aeg_world/                 # World-model contracts and rollout loop
  aeg_adapters_openai/       # OpenAI adapter (placeholder)
  aeg_adapters_anthropic/    # Anthropic adapter (placeholder)
  aeg_adapters_gemini/       # Gemini adapter (placeholder)
  aeg_adapters_ollama/       # Ollama adapter (placeholder)
```

## Current Capabilities

- Runtime pipeline: guard -> plan -> memory -> model -> eval -> persistence
- Task decomposition contract (`AegRuntime.TaskDecomposer`)
- Human intervention contract (`AegRuntime.HumanIntervention`)
- Default heuristic decomposer + fallback human clarifier
- In-memory memory/persistence via ETS for local dev
- Eval gate (`AegEval.Gate`) for regression control
- Proactive policy abstraction (`AegProactive.Policy`)
- Proactive scheduler with cooldown (`AegProactive.Scheduler`)
- World rollout loop with safety gate (`AegWorld.Rollout` + `AegWorld.SafetyPolicy`)
- Provider retry/fallback routing (`AegRouter`)
- Tool rate limiting and permission checks (`AegTools`)

## Prerequisites

Install on Windows (recommended):

- Erlang/OTP: https://www.erlang.org/downloads
- Elixir: https://elixir-lang.org/install.html#windows
- Git: https://git-scm.com/download/win
- PostgreSQL (for future persistent backend): https://www.postgresql.org/download/windows/
- Ollama (optional local model): https://ollama.com/download/windows

Optional quick install with winget:

```powershell
winget install Erlang.ErlangOTP
winget install Elixir.Elixir
winget install Git.Git
winget install PostgreSQL.PostgreSQL
winget install Ollama.Ollama
```

Validate:

```powershell
elixir -v
mix -v
```

## Getting Started

```powershell
cd %USERPROFILE%\Desktop\aeg
mix deps.get
mix compile
mix test
```

## Quick Usage

```elixir
Aeg.run_task(
  "Plan a vehicle inspection and report risks",
  %{session_id: "sess-1"},
  model_provider: AegAdaptersOllama
)
```

World-model loop example:

```elixir
Aeg.run_world(MyWorldModel, MyActor, %{goal: "safe_lane_change"}, %{speed: 45}, horizon: 10)
```

## Design Contracts

Main behaviours:
- `AegRuntime.ModelProvider`
- `AegRuntime.TaskDecomposer`
- `AegRuntime.HumanIntervention`
- `AegGuard.Policy`
- `AegMemory.Store`
- `AegPersistence.Repo`
- `AegProactive.Policy`
- `AegWorld.WorldModel`
- `AegWorld.Actor`
- `AegWorld.SafetyPolicy`

## Roadmap (Short-Term)

1. Real HTTP adapters for OpenAI/Anthropic/Gemini/Ollama.
2. Postgres-backed persistence + migrations.
3. Stronger guard packs (prompt injection, PII, tool abuse).
4. CI with eval gates as release blockers.
5. Example app (Phoenix/LiveView + Oban).

## Publish to GitHub

```powershell
cd %USERPROFILE%\Desktop\aeg
git init
git add .
git commit -m "feat: initial aeg scaffold"
# create repo on GitHub first, then:
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

## CI

GitHub Actions workflow at `.github/workflows/ci.yml` runs:
- `mix deps.get`
- `mix format --check-formatted`
- `mix compile --warnings-as-errors`
- `mix test`

## License

Apache License 2.0. See `LICENSE`.

## Advanced Feature Apps

- `aeg_tools`: tool registry, permissions and execution contracts.
- `aeg_router`: model routing/failover across providers.
- `aeg_multi_agent`: planner/executor/critic orchestration.
- `aeg_gateway`: channel/webhook gateway entrypoint.
- `aeg_skills`: skill packages mapping intents to tools.
- `aeg_observability`: telemetry event wrappers.
- `aeg_mcp`: MCP bridge contracts and normalization.
- `aeg_world_reasoning`: reasoning-action alignment for AV/world loops.

These modules are scaffolded and partially implemented to accelerate feature parity work.

## RL Training (New)

`aeg_rl` adds basic RL support:
- `AegRL.Environment` behaviour
- `AegRL.Policy` behaviour
- `AegRL.EpsilonGreedyPolicy`
- `AegRL.Trainer` (tabular Q-learning)
- `AegRL.WorldEnvAdapter` for world-model integration

Example:

```elixir
AegRL.Trainer.train(
  AegRL.WorldEnvAdapter,
  AegRL.EpsilonGreedyPolicy,
  world_model: MyWorldModel,
  episodes: 200,
  epsilon: 0.2,
  alpha: 0.1,
  gamma: 0.95
)
```
