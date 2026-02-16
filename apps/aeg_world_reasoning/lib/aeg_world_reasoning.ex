defmodule AegWorldReasoning do
  @moduledoc """
  Reasoning and trajectory alignment utilities for world-model/AV loops.
  """

  @spec align(map(), map()) :: :ok | {:error, term()}
  def align(reasoning, action_plan) do
    if Map.has_key?(reasoning, :hazards) and Map.has_key?(action_plan, :trajectory) do
      :ok
    else
      {:error, :reasoning_action_misaligned}
    end
  end
end
