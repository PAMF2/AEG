defmodule AegMemory.Store do
  @moduledoc """
  Behaviour for memory backends.
  """

  @callback put(String.t(), map()) :: :ok | {:error, term()}
  @callback fetch(String.t()) :: {:ok, [map()]} | {:error, term()}
end
