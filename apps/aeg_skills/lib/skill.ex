defmodule AegSkills.Skill do
  @moduledoc """
  Behaviour for skill modules.
  """

  @callback match?(String.t(), map()) :: boolean()
  @callback plan(String.t(), map()) :: map()
end
