defmodule AegProactive.MixProject do
  use Mix.Project

  def project do
    [
      app: :aeg_proactive,
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
      mod: {AegProactive.Application, []}
    ]
  end

  defp deps do
    []
  end
end
