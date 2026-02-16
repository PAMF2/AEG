defmodule AegGuard.Policy.Default do
  @moduledoc """
  Default policy with lightweight risk scoring.
  """

  @behaviour AegGuard.Policy

  alias AegGuard.Decision

  @blocked_keywords ["ignore all instructions", "disable safety", "bypass guardrails", "exfiltrate", "jailbreak"]
  @intercept_keywords ["base64", "hex", "override", "system prompt", "developer message"]

  @impl true
  def evaluate(input, _context) when is_binary(input) do
    normalized = String.downcase(input)
    block_hits = keyword_hits(normalized, @blocked_keywords)
    intercept_hits = keyword_hits(normalized, @intercept_keywords)
    risk_score = min(block_hits * 0.45 + intercept_hits * 0.2, 1.0)

    cond do
      block_hits > 0 ->
        %Decision{
          action: :block,
          reason: :prompt_injection,
          metadata: %{risk_score: risk_score, block_hits: block_hits, intercept_hits: intercept_hits}
        }

      intercept_hits > 0 ->
        %Decision{
          action: :intercept,
          reason: :suspicious_intent,
          metadata: %{risk_score: risk_score, block_hits: block_hits, intercept_hits: intercept_hits}
        }

      true ->
        %Decision{
          action: :allow,
          reason: :ok,
          metadata: %{risk_score: risk_score, block_hits: block_hits, intercept_hits: intercept_hits}
        }
    end
  end

  def evaluate(_input, _context) do
    %Decision{action: :intercept, reason: :invalid_input, metadata: %{}}
  end

  defp keyword_hits(text, keywords) do
    Enum.count(keywords, &String.contains?(text, &1))
  end
end
