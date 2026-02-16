defmodule AegGuard.Policy do
  @moduledoc """
  Behaviour for guard policies.
  """

  alias AegGuard.Decision

  @callback evaluate(String.t(), map()) :: Decision.t()
end
