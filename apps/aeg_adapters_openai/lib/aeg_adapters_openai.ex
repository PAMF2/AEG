defmodule AegAdaptersOpenAI do
  @moduledoc """
  OpenAI adapter placeholder implementing `AegRuntime.ModelProvider`.
  """

  @behaviour AegRuntime.ModelProvider

  @impl true
  def complete(messages, _opts) do
    {:ok, %{provider: :openai, text: "OpenAI adapter placeholder", messages: messages}}
  end
end
