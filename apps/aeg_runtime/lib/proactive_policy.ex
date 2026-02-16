defmodule AegRuntime.ProactivePolicy do
  @moduledoc """
  Compatibility alias for proactive policy behaviour.
  """

  @behaviour AegProactive.Policy

  @impl true
  def can_initiate?(trigger, state, opts) do
    AegProactive.DefaultPolicy.can_initiate?(trigger, state, opts)
  end

  @impl true
  def build_message(trigger, state, opts) do
    AegProactive.DefaultPolicy.build_message(trigger, state, opts)
  end
end
