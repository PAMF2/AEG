# Research Notes (Primary Sources)

Date: 2026-02-16

## OpenClaw

- Repository: https://github.com/openclaw/openclaw
- Nix packaging: https://github.com/openclaw/nix-openclaw

Observed capabilities from official docs/repo:
- Gateway model (`you -> gateway -> tools`) with always-on daemon flow.
- Multi-channel messaging integrations and webhook triggers.
- Plugin/skill packaging where skills teach tool usage.
- Model auth/failover patterns.

## NanoAgent

- Repository: https://github.com/hbbio/nanoagent

Observed capabilities:
- Minimal core loop.
- MCP-oriented design where most complexity is externalized to tools/context.

## World Models

- Genie 3 model page: https://deepmind.google/models/genie/
- Genie 3 blog: https://deepmind.google/blog/genie-3-a-new-frontier-for-world-models/
- Project Genie rollout: https://blog.google/innovation-and-ai/models-and-research/google-deepmind/project-genie/

Observed capabilities:
- Real-time interactive generation (~20-24 FPS) and controllable worlds.
- Promptable world events and consistency constraints.
- Known limitations in action space and interaction duration.

## Autonomous Driving World Models / Reasoning

- GAIA-1 paper: https://arxiv.org/abs/2309.17080
- Wayve GAIA scaling: https://wayve.ai/thinking/scaling-gaia-1/
- NVIDIA Alpamayo publication: https://research.nvidia.com/publication/2025-10_alpamayo-r1
- NVIDIA code: https://github.com/NVlabs/alpamayo

Observed capabilities:
- Video/text/action-conditioned world modeling for driving.
- Reasoning + trajectory alignment emphasis.
- Simulation/evaluation loops for safety-critical scenarios.
