defmodule AegWorld.SafetyPolicy do
  @moduledoc """
  Behaviour for action safety checks in world-model loops.
  """

  @callback allow_action?(goal :: map(), state :: map(), action :: map(), opts :: keyword()) ::
              true | {:halt, term()}
end
