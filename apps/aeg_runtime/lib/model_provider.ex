defmodule AegRuntime.ModelProvider do
  @moduledoc """
  Behaviour for model providers.
  """

  @callback complete(messages :: [map()], opts :: keyword()) ::
              {:ok, map()} | {:error, term()}
end
