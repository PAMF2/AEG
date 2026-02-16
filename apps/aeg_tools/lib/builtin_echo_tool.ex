defmodule AegTools.BuiltinEchoTool do
  @moduledoc false
  @behaviour AegTools.Tool

  @impl true
  def name, do: "echo"

  @impl true
  def validate, do: :ok

  @impl true
  def call(input, _context), do: {:ok, %{echo: input}}
end
