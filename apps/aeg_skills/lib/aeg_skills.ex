defmodule AegSkills do
  @moduledoc """
  Skill packages mapping intents to tool invocations.
  """

  @spec resolve([module()], String.t(), map()) :: {:ok, map()} | {:error, :no_skill}
  def resolve(skills, intent, context) do
    case Enum.find(skills, fn skill -> skill.match?(intent, context) end) do
      nil -> {:error, :no_skill}
      skill -> {:ok, skill.plan(intent, context)}
    end
  end
end
