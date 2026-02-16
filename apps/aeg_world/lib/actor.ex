defmodule AegWorld.Actor do
  @moduledoc """
  Behaviour for choosing actions from goal and current world state.
  """

  @type goal :: map()
  @type state :: map()
  @type action :: map()

  @callback choose_action(goal(), state(), opts :: keyword()) ::
              {:ok, action()} | {:halt, term()} | {:error, term()}
end
