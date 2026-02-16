defmodule AegGuard.Policy.Default do
  @moduledoc """
  Minimal default policy with conservative keyword checks.
  """

  @behaviour AegGuard.Policy

  alias AegGuard.Decision

  @blocked_keywords ["ignore all instructions", "disable safety", "bypass guardrails"]

  @impl true
  def evaluate(input, _context) when is_binary(input) do
    normalized = String.downcase(input)

    if Enum.any?(@blocked_keywords, &String.contains?(normalized, &1)) do
      %Decision{action: :block, reason: :prompt_injection, metadata: %{matched: true}}
    else
      %Decision{action: :allow, reason: :ok, metadata: %{matched: false}}
    end
  end

  def evaluate(_input, _context) do
    %Decision{action: :intercept, reason: :invalid_input, metadata: %{}}
  end
end
