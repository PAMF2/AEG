defmodule AegRuntime.Engine do
  @moduledoc """
  End-to-end runtime pipeline: guard -> plan -> memory -> model -> eval.
  """

  alias AegGuard.Decision

  @spec run(String.t() | map(), map(), keyword()) :: {:ok, map()} | {:error, term()}
  def run(task, context \\ %{}, opts \\ []) do
    input = task_to_string(task)
    guard_policy = Keyword.get(opts, :guard_policy, AegGuard.Policy.Default)

    case AegGuard.check(input, context, guard_policy) do
      %Decision{action: :block} = decision ->
        {:error, {:blocked, decision.reason}}

      %Decision{} = decision ->
        with {:ok, subgoals} <- plan(task, context, opts),
             :ok <- store_memory(context, input, subgoals, opts),
             {:ok, output} <- run_model(subgoals, opts),
             :ok <- maybe_run_evals(output, opts),
             :ok <- persist_event(context, input, subgoals, output, decision, opts) do
          {:ok, %{decision: decision, subgoals: subgoals, output: output}}
        end
    end
  end

  defp plan(task, context, opts) do
    decomposer = Keyword.get(opts, :decomposer, AegRuntime.DefaultDecomposer)
    human = Keyword.get(opts, :human, AegRuntime.HumanConsole)
    AegRuntime.Planner.plan(decomposer, human, task, context, opts)
  end

  defp store_memory(context, input, subgoals, opts) do
    session_id = Map.get(context, :session_id, "default")
    store = Keyword.get(opts, :memory_store, AegMemory.InMemoryStore)

    AegMemory.put(store, session_id, %{input: input, subgoals: subgoals, inserted_at: DateTime.utc_now()})
  end

  defp run_model(subgoals, opts) do
    provider = Keyword.get(opts, :model_provider)

    if is_nil(provider) do
      {:ok, %{text: "No provider configured", subgoal_count: length(subgoals)}}
    else
      messages = [%{role: "user", content: "Execute subgoals: #{inspect(subgoals)}"}]
      provider.complete(messages, opts)
    end
  end

  defp maybe_run_evals(output, opts) do
    eval_cases = Keyword.get(opts, :eval_cases, [])

    if eval_cases == [] do
      :ok
    else
      results = AegEval.run(eval_cases, fn _case -> output end)
      AegEval.Gate.enforce(results, min_pass_rate: Keyword.get(opts, :eval_min_pass_rate, 1.0))
    end
  end

  defp persist_event(context, input, subgoals, output, decision, opts) do
    repo = Keyword.get(opts, :persistence_repo, AegPersistence.InMemoryRepo)
    session_id = Map.get(context, :session_id, "default")

    event = %{
      type: :runtime_run,
      input: input,
      subgoals: subgoals,
      output: output,
      decision: Map.from_struct(decision)
    }

    AegPersistence.append_event(repo, session_id, event)
  end

  defp task_to_string(task) when is_binary(task), do: task
  defp task_to_string(task) when is_map(task), do: inspect(task)
end
