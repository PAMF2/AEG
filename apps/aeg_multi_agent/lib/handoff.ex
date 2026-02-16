defmodule AegMultiAgent.Handoff do
  @moduledoc """
  Typed handoff envelope between agents.
  """

  @enforce_keys [:from, :to, :payload]
  defstruct from: nil, to: nil, payload: %{}, metadata: %{}

  @type t :: %__MODULE__{from: atom(), to: atom(), payload: map(), metadata: map()}
end
