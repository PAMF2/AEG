defmodule AegGateway.WebhookTrigger do
  @moduledoc """
  Normalizes external webhook events into inbound gateway messages.
  """

  @spec to_message(map()) :: map()
  def to_message(event) do
    %{
      session_id: Map.get(event, "session_id", "default"),
      content: Map.get(event, "content", ""),
      channel: Map.get(event, "channel", "webhook"),
      metadata: event
    }
  end
end
