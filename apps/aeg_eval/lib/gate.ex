defmodule AegEval.Gate do
  @moduledoc """
  Aggregates eval results and enforces a minimum pass rate.
  """

  alias AegEval.Result

  @spec enforce([Result.t()], keyword()) :: :ok | {:error, term()}
  def enforce(results, opts \\ []) do
    min_pass_rate = Keyword.get(opts, :min_pass_rate, 1.0)
    total = max(length(results), 1)
    passed = Enum.count(results, & &1.passed)
    pass_rate = passed / total

    if pass_rate >= min_pass_rate do
      :ok
    else
      {:error, {:eval_gate_failed, %{pass_rate: pass_rate, min_pass_rate: min_pass_rate}}}
    end
  end
end
