defmodule AegEval.EvalCase do
  @moduledoc """
  Single evaluation case.
  """

  @enforce_keys [:id, :input, :expected]
  defstruct id: nil, input: %{}, expected: %{}, threshold: 1.0

  @type t :: %__MODULE__{
          id: String.t(),
          input: map(),
          expected: map(),
          threshold: float()
        }
end
