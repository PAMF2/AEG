defmodule AegWorldReasoning.Evaluator do
  @moduledoc """
  Lightweight evaluator for world-model safety rollouts.
  """

  @spec score([map()]) :: map()
  def score(transitions) do
    count = length(transitions)
    unsafe = Enum.count(transitions, fn t -> Map.get(t, :unsafe, false) end)
    %{steps: count, unsafe_steps: unsafe, safety_rate: (count - unsafe) / max(count, 1)}
  end
end
