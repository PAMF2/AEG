defmodule AegWorld.WorldModel do
  @moduledoc """
  Behaviour for world-model backends.

  A world model must expose state transitions and observations resulting from
  agent actions.
  """

  @type state :: map()
  @type action :: map()
  @type observation :: map()

  @callback reset(opts :: keyword()) :: {:ok, state()} | {:error, term()}
  @callback step(state(), action(), opts :: keyword()) ::
              {:ok, state(), observation()} | {:error, term()}
end
