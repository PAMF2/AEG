defmodule AegRL.EpsilonGreedyPolicy do
  @moduledoc """
  Epsilon-greedy exploration policy for tabular Q-learning.
  """

  @behaviour AegRL.Policy

  @impl true
  def select_action(state_key, actions, q_table, opts) do
    epsilon = Keyword.get(opts, :epsilon, 0.1)

    if :rand.uniform() < epsilon do
      Enum.random(actions)
    else
      best_action(actions, q_table, state_key)
    end
  end

  defp best_action(actions, q_table, state_key) do
    Enum.max_by(actions, fn action -> Map.get(q_table, {state_key, action}, 0.0) end)
  end
end
