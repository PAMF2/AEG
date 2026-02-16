import Config

config :aeg,
  default_guard_policy: AegGuard.Policy.Default,
  default_memory_store: AegMemory.InMemoryStore,
  default_decomposer: AegRuntime.DefaultDecomposer,
  default_human_intervention: AegRuntime.HumanConsole
