defmodule AegRouterTest do
  use ExUnit.Case, async: true

  defmodule FailProvider do
    def complete(_messages, _opts), do: {:error, :down}
  end

  defmodule OkProvider do
    def complete(_messages, _opts), do: {:ok, %{text: "ok"}}
  end

  test "falls back to next provider" do
    assert {:ok, %{provider: OkProvider}} =
             AegRouter.complete([FailProvider, OkProvider], [%{role: "user", content: "x"}], provider_retries: 0)
  end
end
