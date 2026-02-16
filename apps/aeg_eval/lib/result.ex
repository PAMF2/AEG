defmodule AegEval.Result do
  @moduledoc """
  Result for one eval case.
  """

  @enforce_keys [:case_id, :score, :passed, :output]
  defstruct case_id: nil, score: 0.0, passed: false, output: %{}

  @type t :: %__MODULE__{
          case_id: String.t(),
          score: float(),
          passed: boolean(),
          output: map()
        }
end
