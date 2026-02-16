defmodule AegTools.Registry do
  @moduledoc """
  In-memory registry of tool modules.
  """

  @table :aeg_tools_registry

  @spec register(String.t(), module()) :: :ok
  def register(name, mod) do
    init_table()
    true = :ets.insert(@table, {name, mod})
    :ok
  end

  @spec fetch(module(), String.t()) :: {:ok, module()} | {:error, :not_found}
  def fetch(_registry, name) do
    init_table()

    case :ets.lookup(@table, name) do
      [{^name, mod}] -> {:ok, mod}
      [] -> {:error, :not_found}
    end
  end

  defp init_table do
    case :ets.whereis(@table) do
      :undefined -> :ets.new(@table, [:named_table, :public, :set])
      _tid -> :ok
    end
  end
end
