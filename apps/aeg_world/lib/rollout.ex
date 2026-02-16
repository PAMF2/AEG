defmodule AegWorld.Rollout do
  @moduledoc """
  Executes act-observe loops in a world model with optional safety gating.
  """

  @spec run(module(), module(), map(), map(), keyword()) :: {:ok, map(), [map()]} | {:error, term()}
  def run(world_model, actor, goal, initial_state, opts \\ []) do
    horizon = Keyword.get(opts, :horizon, 5)
    safety_policy = Keyword.get(opts, :safety_policy, AegWorld.DefaultSafetyPolicy)
    do_run(world_model, actor, safety_policy, goal, initial_state, horizon, [])
  end

  defp do_run(_world_model, _actor, _safety, _goal, state, 0, history), do: {:ok, state, Enum.reverse(history)}

  defp do_run(world_model, actor, safety_policy, goal, state, steps_left, history) do
    with {:ok, action} <- actor.choose_action(goal, state, []),
         true <- safety_policy.allow_action?(goal, state, action, []),
         {:ok, next_state, observation} <- world_model.step(state, action, []) do
      transition = %{action: action, observation: observation, state: next_state}
      do_run(world_model, actor, safety_policy, goal, next_state, steps_left - 1, [transition | history])
    else
      {:halt, reason} -> {:error, {:unsafe_action, reason}}
      false -> {:error, {:unsafe_action, :policy_rejected}}
      {:error, reason} -> {:error, reason}
    end
  end
end
