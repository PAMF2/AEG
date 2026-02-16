defmodule AegTools do
  @moduledoc """
  Tool execution engine with permission checks and rate limiting.
  """

  alias AegTools.{Context, RateLimiter, Registry}

  @spec call(module(), String.t(), map(), Context.t()) :: {:ok, map()} | {:error, term()}
  def call(registry, tool_name, input, %Context{} = context) do
    with {:ok, tool} <- Registry.fetch(registry, tool_name),
         :ok <- authorize(tool, context),
         :ok <- enforce_rate_limit(tool_name, context),
         {:ok, output} <- tool.call(input, context) do
      {:ok, output}
    end
  end

  defp authorize(tool, %Context{allowed_tools: :all}), do: tool.validate()

  defp authorize(tool, %Context{allowed_tools: allowed}) when is_list(allowed) do
    if tool.name() in allowed do
      tool.validate()
    else
      {:error, :tool_not_allowed}
    end
  end

  defp enforce_rate_limit(tool_name, %Context{} = context) do
    limit = Map.get(context.metadata, :tool_rate_limit, 30)
    window_ms = Map.get(context.metadata, :tool_rate_window_ms, 60_000)
    key = "#{context.session_id}:#{tool_name}"
    RateLimiter.allow?(key, limit, window_ms)
  end
end
