defmodule AegTools.Tool do
  @moduledoc """
  Behaviour for tools.
  """

  @callback name() :: String.t()
  @callback validate() :: :ok | {:error, term()}
  @callback call(map(), AegTools.Context.t()) :: {:ok, map()} | {:error, term()}
end
