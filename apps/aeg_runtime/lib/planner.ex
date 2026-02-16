defmodule AegRuntime.Planner do
  @moduledoc """
  Planner that handles task decomposition and falls back to human clarification.
  """

  @spec plan(module(), module(), String.t() | map(), map(), keyword()) ::
          {:ok, [map()]} | {:error, term()}
  def plan(decomposer, human, task, context, opts \\ []) do
    case decomposer.decompose(task, context, opts) do
      {:ok, subgoals} ->
        {:ok, subgoals}

      {:need_human, question} ->
        with {:ok, response} <- human.ask(question, opts),
             {:ok, subgoals} <- decomposer.refine(task, context, response, opts) do
          {:ok, subgoals}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end
end
