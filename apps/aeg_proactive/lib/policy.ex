defmodule AegProactive.Policy do
  @moduledoc """
  Behaviour for proactive messaging policies.
  """

  @type trigger :: map()
  @type state :: map()

  @callback can_initiate?(trigger(), state(), opts :: keyword()) :: boolean()
  @callback build_message(trigger(), state(), opts :: keyword()) :: {:ok, String.t()} | {:error, term()}
end
