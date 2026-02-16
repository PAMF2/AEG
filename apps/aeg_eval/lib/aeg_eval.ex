defmodule AegEval do
  @moduledoc """
  Evaluation helpers for task quality and safety.
  """

  alias AegEval.{EvalCase, Result}

  @spec run([EvalCase.t()], (EvalCase.t() -> map())) :: [Result.t()]
  def run(cases, runner_fun) when is_list(cases) and is_function(runner_fun, 1) do
    Enum.map(cases, fn eval_case ->
      output = runner_fun.(eval_case)
      score = score(eval_case.expected, output)
      %Result{case_id: eval_case.id, score: score, passed: score >= eval_case.threshold, output: output}
    end)
  end

  defp score(expected, output) when expected == output, do: 1.0
  defp score(_expected, _output), do: 0.0
end
