defmodule AegToolsTest do
  use ExUnit.Case, async: true

  setup do
    AegTools.Registry.register("echo", AegTools.BuiltinEchoTool)
    :ok
  end

  test "executes allowed tool" do
    ctx = %AegTools.Context{session_id: "s1", allowed_tools: ["echo"]}
    assert {:ok, %{echo: %{value: 1}}} = AegTools.call(AegTools.Registry, "echo", %{value: 1}, ctx)
  end

  test "blocks disallowed tool" do
    ctx = %AegTools.Context{session_id: "s1", allowed_tools: ["other"]}
    assert {:error, :tool_not_allowed} = AegTools.call(AegTools.Registry, "echo", %{}, ctx)
  end
end
