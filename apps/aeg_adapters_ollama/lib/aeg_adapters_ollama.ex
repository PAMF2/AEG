defmodule AegAdaptersOllama do
  @moduledoc """
  Ollama adapter placeholder implementing `AegRuntime.ModelProvider`.
  """

  @behaviour AegRuntime.ModelProvider

  @impl true
  def complete(messages, _opts) do
    {:ok, %{provider: :ollama, text: "Ollama adapter placeholder", messages: messages}}
  end
end
