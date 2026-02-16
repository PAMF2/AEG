defmodule AegRL.WorldEnvAdapter do
  @moduledoc """
  Adapter pattern for using `AegWorld.WorldModel` as RL environment.
  """

  @behaviour AegRL.Environment

  @impl true
  def reset(opts) do
    model = Keyword.fetch!(opts, :world_model)
    model.reset(opts)
  end

  @impl true
  def actions(state) do
    Map.get(state, :actions, [])
  end

  @impl true
  def step(state, action, opts) do
    model = Keyword.fetch!(opts, :world_model)

    with {:ok, next_state, observation} <- model.step(state, action, opts) do
      reward = Map.get(observation, :reward, 0.0)
      done = Map.get(observation, :done, false)
      {:ok, next_state, reward, done}
    end
  end

  @impl true
  def state_key(state), do: state
end
