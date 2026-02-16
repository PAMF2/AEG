defmodule AegProactive.Scheduler do
  @moduledoc """
  Basic proactive scheduler with cooldown support.
  """

  @table :aeg_proactive_scheduler

  @spec maybe_emit(module(), map(), map(), keyword()) :: {:ok, String.t()} | :skip | {:error, term()}
  def maybe_emit(policy, trigger, state, opts \\ []) do
    cooldown_ms = Keyword.get(opts, :cooldown_ms, 30_000)
    id = Map.get(trigger, :id, "default")

    if cooldown_elapsed?(id, cooldown_ms) do
      result = AegProactive.maybe_initiate(policy, trigger, state, opts)
      mark(id)
      result
    else
      :skip
    end
  end

  defp cooldown_elapsed?(id, cooldown_ms) do
    init_table()
    now = System.system_time(:millisecond)

    case :ets.lookup(@table, id) do
      [{^id, last_at}] -> now - last_at >= cooldown_ms
      [] -> true
    end
  end

  defp mark(id) do
    init_table()
    now = System.system_time(:millisecond)
    :ets.insert(@table, {id, now})
    :ok
  end

  defp init_table do
    case :ets.whereis(@table) do
      :undefined -> :ets.new(@table, [:named_table, :public, :set])
      _tid -> :ok
    end
  end
end
