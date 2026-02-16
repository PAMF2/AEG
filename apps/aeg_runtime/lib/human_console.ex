defmodule AegRuntime.HumanConsole do
  @moduledoc """
  Simple human intervention provider for non-interactive bootstrap.
  """

  @behaviour AegRuntime.HumanIntervention

  @impl true
  def ask(question, _opts) do
    prompt = Map.get(question, :prompt) || Map.get(question, "prompt") || "Clarify task"
    {:ok, %{id: Map.get(question, :id, "q1"), answer: prompt, approved: true}}
  end
end
