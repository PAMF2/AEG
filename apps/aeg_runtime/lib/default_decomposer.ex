defmodule AegRuntime.DefaultDecomposer do
  @moduledoc """
  Heuristic task decomposer used as bootstrap implementation.
  """

  @behaviour AegRuntime.TaskDecomposer

  @impl true
  def decompose(task, _context, _opts) when is_binary(task) do
    parts =
      task
      |> String.split([".", "\n", ";"], trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))

    case parts do
      [] -> {:need_human, %{id: "clarify-1", prompt: "Pode detalhar a tarefa?", metadata: %{original: task}}}
      _ -> {:ok, Enum.with_index(parts, 1) |> Enum.map(fn {p, i} -> %{id: i, instruction: p} end)}
    end
  end

  def decompose(task, _context, _opts) when is_map(task) do
    case Map.get(task, :subgoals) || Map.get(task, "subgoals") do
      goals when is_list(goals) and goals != [] -> {:ok, goals}
      _ -> {:need_human, %{id: "clarify-1", prompt: "Quais subobjetivos devemos seguir?"}}
    end
  end

  @impl true
  def refine(task, context, response, opts) do
    answer = Map.get(response, :answer) || Map.get(response, "answer") || ""
    decompose("#{task}. #{answer}", context, opts)
  end
end
