defmodule AegMultiAgent.Role do
  @moduledoc """
  Behaviour for each role in multi-agent workflows.
  """

  @callback run(map(), keyword()) :: {:ok, map()} | {:error, term()}
end
