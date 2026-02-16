defmodule AegMemory do
  @moduledoc """
  Context and memory orchestration.
  """

  @spec put(module(), String.t(), map()) :: :ok | {:error, term()}
  def put(store, session_id, entry), do: store.put(session_id, entry)

  @spec fetch(module(), String.t()) :: {:ok, [map()]} | {:error, term()}
  def fetch(store, session_id), do: store.fetch(session_id)
end
