defmodule AegRL.Policy do
  @moduledoc """
  Policy behaviour for choosing actions.
  """

  @callback select_action(state :: term(), actions :: [term()], q_table :: map(), keyword()) :: term()
end
