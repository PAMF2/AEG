defmodule AegTools.RateLimiter do
  @moduledoc """
  ETS-backed fixed window rate limiter.
  """

  @table :aeg_tool_rate_limiter

  @spec allow?(String.t(), pos_integer(), pos_integer()) :: :ok | {:error, :rate_limited}
  def allow?(key, limit, window_ms) when is_binary(key) and limit > 0 and window_ms > 0 do
    init_table()
    now = System.system_time(:millisecond)
    window_bucket = div(now, window_ms)
    bucket_key = {key, window_bucket}

    count =
      case :ets.lookup(@table, bucket_key) do
        [{^bucket_key, current}] -> current
        [] -> 0
      end

    if count < limit do
      :ets.insert(@table, {bucket_key, count + 1})
      :ok
    else
      {:error, :rate_limited}
    end
  end

  defp init_table do
    case :ets.whereis(@table) do
      :undefined -> :ets.new(@table, [:named_table, :public, :set])
      _tid -> :ok
    end
  end
end
