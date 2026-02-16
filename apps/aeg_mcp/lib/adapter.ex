defmodule AegMCP.Adapter do
  @moduledoc """
  Normalizes MCP tool schemas to `AegTools.Tool` contracts.
  """

  @spec normalize_tool(map()) :: map()
  def normalize_tool(tool_spec) do
    %{
      name: Map.get(tool_spec, "name"),
      description: Map.get(tool_spec, "description", ""),
      input_schema: Map.get(tool_spec, "inputSchema", %{})
    }
  end
end
