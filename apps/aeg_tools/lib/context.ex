defmodule AegTools.Context do
  @moduledoc """
  Execution context for tools.
  """

  @enforce_keys [:session_id]
  defstruct session_id: nil, user_id: nil, allowed_tools: :all, metadata: %{}

  @type t :: %__MODULE__{
          session_id: String.t(),
          user_id: String.t() | nil,
          allowed_tools: :all | [String.t()],
          metadata: map()
        }
end
