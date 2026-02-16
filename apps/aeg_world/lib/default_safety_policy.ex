defmodule AegWorld.DefaultSafetyPolicy do
  @moduledoc """
  Default permissive safety policy.
  """

  @behaviour AegWorld.SafetyPolicy

  @impl true
  def allow_action?(_goal, _state, _action, _opts), do: true
end
