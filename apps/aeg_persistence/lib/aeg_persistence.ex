defmodule AegPersistence do
  @moduledoc """
  Persistence abstraction for sessions, events and audit trails.
  """

  @spec append_event(module(), String.t(), map()) :: :ok | {:error, term()}
  def append_event(repo, session_id, event), do: repo.append_event(session_id, event)

  @spec events(module(), String.t()) :: {:ok, [map()]} | {:error, term()}
  def events(repo, session_id), do: repo.events(session_id)
end
