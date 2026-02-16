defmodule AegRuntime.MixProject do
  use Mix.Project

  def project do
    [
      app: :aeg_runtime,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {AegRuntime.Application, []}
    ]
  end

  defp deps do
    [
      {:aeg_guard, in_umbrella: true},
      {:aeg_eval, in_umbrella: true},
      {:aeg_memory, in_umbrella: true},
      {:aeg_proactive, in_umbrella: true},
      {:aeg_persistence, in_umbrella: true},
      {:aeg_world, in_umbrella: true},
      {:aeg_router, in_umbrella: true},
      {:aeg_tools, in_umbrella: true},
      {:aeg_observability, in_umbrella: true}
    ]
  end
end
