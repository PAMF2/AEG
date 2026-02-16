defmodule AegSkills.Registry do
  @moduledoc """
  In-memory skill registry.
  """

  @table :aeg_skills_registry

  @spec register(module()) :: :ok
  def register(skill_module) do
    init_table()
    true = :ets.insert(@table, {skill_module, skill_module})
    :ok
  end

  @spec list() :: [module()]
  def list do
    init_table()
    @table |> :ets.tab2list() |> Enum.map(fn {_k, mod} -> mod end)
  end

  defp init_table do
    case :ets.whereis(@table) do
      :undefined -> :ets.new(@table, [:named_table, :public, :set])
      _tid -> :ok
    end
  end
end
