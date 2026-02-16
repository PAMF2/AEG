defmodule AegGateway do
  @moduledoc """
  Channel-facing gateway inspired by personal-assistant flows.
  """

  @spec handle_inbound(map(), keyword()) :: {:ok, map()} | {:error, term()}
  def handle_inbound(message, opts) do
    runtime = Keyword.get(opts, :runtime, AegRuntime.Engine)
    session_id = Map.get(message, :session_id, "default")
    content = Map.get(message, :content, "")
    channel = Map.get(message, :channel, :web)

    runtime.run(content, %{session_id: session_id, channel: channel}, opts)
  end
end
