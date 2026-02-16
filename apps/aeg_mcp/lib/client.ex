defmodule AegMCP.Client do
  @moduledoc """
  Behaviour for MCP clients.
  """

  @callback list_tools(keyword()) :: {:ok, [map()]} | {:error, term()}
  @callback call_tool(String.t(), map(), keyword()) :: {:ok, map()} | {:error, term()}
end
