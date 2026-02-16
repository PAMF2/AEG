defmodule Aeg do
  @moduledoc """
  Public facade for tasks, multi-agent flows and world-model rollouts.
  """

  @spec run_task(String.t() | map(), map(), keyword()) :: {:ok, map()} | {:error, term()}
  def run_task(task, context \\ %{}, opts \\ []), do: AegRuntime.Engine.run(task, context, opts)

  @spec run_multi_agent(map(), keyword()) :: {:ok, map()} | {:error, term()}
  def run_multi_agent(task, opts \\ []), do: AegMultiAgent.run(task, opts)

  @spec gateway_message(map(), keyword()) :: {:ok, map()} | {:error, term()}
  def gateway_message(message, opts \\ []), do: AegGateway.handle_inbound(message, opts)

  @spec run_world(module(), module(), map(), map(), keyword()) :: {:ok, map(), [map()]} | {:error, term()}
  def run_world(world_model, actor, goal, initial_state, opts \\ []) do
    AegWorld.Rollout.run(world_model, actor, goal, initial_state, opts)
  end
end
