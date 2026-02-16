defmodule AegAdaptersGemini do
  @moduledoc """
  Gemini adapter placeholder implementing `AegRuntime.ModelProvider`.
  """

  @behaviour AegRuntime.ModelProvider

  @impl true
  def complete(messages, _opts) do
    {:ok, %{provider: :gemini, text: "Gemini adapter placeholder", messages: messages}}
  end
end
