defmodule AegRuntime.TaskDecomposer do
  @moduledoc """
  Behaviour for decomposing generic tasks/goals into executable sub-goals.
  """

  @type task :: String.t() | map()
  @type context :: map()
  @type subgoal :: map()
  @type human_response :: map()

  @callback decompose(task(), context(), opts :: keyword()) ::
              {:ok, [subgoal()]} | {:need_human, map()} | {:error, term()}

  @callback refine(task(), context(), human_response(), opts :: keyword()) ::
              {:ok, [subgoal()]} | {:error, term()}
end
