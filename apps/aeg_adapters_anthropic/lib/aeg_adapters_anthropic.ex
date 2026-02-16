defmodule AegAdaptersAnthropic do
  @moduledoc """
  Anthropic adapter placeholder implementing `AegRuntime.ModelProvider`.
  """

  @behaviour AegRuntime.ModelProvider

  @impl true
  def complete(messages, _opts) do
    {:ok, %{provider: :anthropic, text: "Anthropic adapter placeholder", messages: messages}}
  end
end
