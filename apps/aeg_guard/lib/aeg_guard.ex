defmodule AegGuard do
  @moduledoc """
  Guardrails and policy orchestration.
  """

  alias AegGuard.Decision

  @spec check(String.t(), map(), module()) :: Decision.t()
  def check(input, context, policy_module \\ AegGuard.Policy.Default) do
    policy_module.evaluate(input, context)
  end
end
