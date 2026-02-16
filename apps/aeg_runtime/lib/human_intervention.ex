defmodule AegRuntime.HumanIntervention do
  @moduledoc """
  Behaviour for human-in-the-loop clarification and approval.
  """

  @type question :: %{
          required(:id) => String.t(),
          required(:prompt) => String.t(),
          optional(:choices) => [String.t()],
          optional(:metadata) => map()
        }

  @type response :: %{
          required(:id) => String.t(),
          required(:answer) => String.t(),
          optional(:approved) => boolean(),
          optional(:metadata) => map()
        }

  @callback ask(question(), opts :: keyword()) ::
              {:ok, response()} | {:timeout, term()} | {:error, term()}
end
