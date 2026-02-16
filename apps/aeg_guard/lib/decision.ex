defmodule AegGuard.Decision do
  @moduledoc """
  Safety decision returned by guard policies.
  """

  @enforce_keys [:action]
  defstruct action: :allow, reason: :ok, metadata: %{}

  @type action :: :allow | :intercept | :block
  @type t :: %__MODULE__{action: action(), reason: term(), metadata: map()}
end
