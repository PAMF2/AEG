defmodule AegWorldReasoning.Trace do
  @moduledoc """
  Structured chain-of-causation trace.
  """

  @enforce_keys [:situation, :hazards, :decision]
  defstruct situation: "", hazards: [], decision: "", trajectory: %{}, confidence: 0.0

  @type t :: %__MODULE__{
          situation: String.t(),
          hazards: [String.t()],
          decision: String.t(),
          trajectory: map(),
          confidence: float()
        }
end
