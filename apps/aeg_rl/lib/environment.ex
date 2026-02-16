defmodule AegRL.Environment do
  @moduledoc """
  RL environment behaviour.
  """

  @type state :: term()
  @type action :: term()
  @type reward :: number()

  @callback reset(keyword()) :: {:ok, state()} | {:error, term()}
  @callback actions(state()) :: [action()]
  @callback step(state(), action(), keyword()) :: {:ok, state(), reward(), boolean()} | {:error, term()}
  @callback state_key(state()) :: term()
end
