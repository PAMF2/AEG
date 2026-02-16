defmodule AegMultiAgent do
  @moduledoc """
  Multi-agent orchestration with planner/executor/critic roles.
  """

  @spec run(map(), keyword()) :: {:ok, map()} | {:error, term()}
  def run(task, opts \\ []) do
    planner = Keyword.fetch!(opts, :planner)
    executor = Keyword.fetch!(opts, :executor)
    critic = Keyword.fetch!(opts, :critic)

    with {:ok, plan} <- planner.run(task, opts),
         {:ok, execution} <- executor.run(plan, opts),
         {:ok, review} <- critic.run(execution, opts) do
      {:ok, %{plan: plan, execution: execution, review: review}}
    end
  end
end
