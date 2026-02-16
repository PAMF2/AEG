defmodule AegPersistence.Repo do
  @moduledoc """
  Behaviour for persistence implementations.
  """

  @callback append_event(String.t(), map()) :: :ok | {:error, term()}
  @callback events(String.t()) :: {:ok, [map()]} | {:error, term()}
end
