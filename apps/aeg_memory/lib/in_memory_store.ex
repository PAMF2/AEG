defmodule AegMemory.InMemoryStore do
  @moduledoc """
  ETS-backed in-memory store for quick local development.
  """

  @behaviour AegMemory.Store

  @table :aeg_memory_store

  @spec init_table() :: :ok
  def init_table do
    case :ets.whereis(@table) do
      :undefined ->
        :ets.new(@table, [:named_table, :public, :bag])
        :ok

      _tid ->
        :ok
    end
  end

  @impl true
  def put(session_id, entry) when is_binary(session_id) and is_map(entry) do
    init_table()
    true = :ets.insert(@table, {session_id, entry})
    :ok
  rescue
    error -> {:error, error}
  end

  @impl true
  def fetch(session_id) when is_binary(session_id) do
    init_table()

    entries =
      @table
      |> :ets.lookup(session_id)
      |> Enum.map(fn {_key, value} -> value end)

    {:ok, entries}
  rescue
    error -> {:error, error}
  end
end
