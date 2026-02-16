defmodule Aeg do
  @moduledoc """
  Public facade for running tasks and world-model rollouts.
  """

  @spec run_task(String.t() | map(), map(), keyword()) ::
          {:ok, map()} | {:error, term()}
  def run_task(task, context \\ %{}, opts \\ []) do
    AegRuntime.Engine.run(task, context, opts)
  end

  @spec run_world(module(), module(), map(), map(), keyword()) ::
          {:ok, map(), [map()]} | {:error, term()}
  def run_world(world_model, actor, goal, initial_state, opts \\ []) do
    AegWorld.Rollout.run(world_model, actor, goal, initial_state, opts)
  end
end
