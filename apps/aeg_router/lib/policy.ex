defmodule AegRouter.Policy do
  @moduledoc """
  Behaviour for dynamic provider ordering.
  """

  @callback order([module()], map(), keyword()) :: [module()]
end
