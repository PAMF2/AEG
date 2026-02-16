defmodule AegRouter.DefaultPolicy do
  @moduledoc false
  @behaviour AegRouter.Policy

  @impl true
  def order(providers, _context, _opts), do: providers
end
