defmodule AegProactive.DefaultPolicy do
  @moduledoc """
  Basic anti-spam proactive policy.
  """

  @behaviour AegProactive.Policy

  @impl true
  def can_initiate?(trigger, _state, _opts) do
    not Map.get(trigger, :quiet_hours, false)
  end

  @impl true
  def build_message(trigger, _state, _opts) do
    reason = Map.get(trigger, :reason, "status_update")
    {:ok, "Proactive update: #{reason}"}
  end
end
