defmodule AegProactive do
  @moduledoc """
  Proactive messaging orchestration.
  """

  @type trigger :: map()
  @type state :: map()

  @spec maybe_initiate(module(), trigger(), state(), keyword()) ::
          {:ok, String.t()} | :skip | {:error, term()}
  def maybe_initiate(policy, trigger, state, opts \\ []) do
    if policy.can_initiate?(trigger, state, opts) do
      policy.build_message(trigger, state, opts)
    else
      :skip
    end
  end
end
