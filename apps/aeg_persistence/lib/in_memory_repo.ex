defmodule AegPersistence.InMemoryRepo do
  @moduledoc """
  ETS-backed event repository for development.
  """

  @behaviour AegPersistence.Repo

  @table :aeg_persistence_events

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
  def append_event(session_id, event) when is_binary(session_id) and is_map(event) do
    init_table()
    timestamped = Map.put_new(event, :inserted_at, DateTime.utc_now())
    true = :ets.insert(@table, {session_id, timestamped})
    :ok
  rescue
    error -> {:error, error}
  end

  @impl true
  def events(session_id) when is_binary(session_id) do
    init_table()

    records =
      @table
      |> :ets.lookup(session_id)
      |> Enum.map(fn {_key, value} -> value end)

    {:ok, records}
  rescue
    error -> {:error, error}
  end
end
