defmodule AegRL.Trainer do
  @moduledoc """
  Tabular Q-learning trainer.
  """

  @spec train(module(), module(), keyword()) :: {:ok, map()} | {:error, term()}
  def train(env, policy, opts \\ []) do
    episodes = Keyword.get(opts, :episodes, 100)
    alpha = Keyword.get(opts, :alpha, 0.1)
    gamma = Keyword.get(opts, :gamma, 0.95)
    max_steps = Keyword.get(opts, :max_steps, 200)

    q_table = %{}

    Enum.reduce_while(1..episodes, {:ok, q_table}, fn _episode, {:ok, q_acc} ->
      case run_episode(env, policy, q_acc, alpha, gamma, max_steps, opts) do
        {:ok, q_next} -> {:cont, {:ok, q_next}}
        {:error, reason} -> {:halt, {:error, reason}}
      end
    end)
  end

  defp run_episode(env, policy, q_table, alpha, gamma, max_steps, opts) do
    with {:ok, initial_state} <- env.reset(opts) do
      step_loop(env, policy, initial_state, q_table, alpha, gamma, max_steps, opts)
    end
  end

  defp step_loop(_env, _policy, _state, q_table, _alpha, _gamma, 0, _opts), do: {:ok, q_table}

  defp step_loop(env, policy, state, q_table, alpha, gamma, steps_left, opts) do
    state_key = env.state_key(state)
    actions = env.actions(state)

    if actions == [] do
      {:ok, q_table}
    else
      action = policy.select_action(state_key, actions, q_table, opts)

      with {:ok, next_state, reward, done} <- env.step(state, action, opts) do
        next_key = env.state_key(next_state)
        next_best = max_next_q(env.actions(next_state), q_table, next_key)
        old_q = Map.get(q_table, {state_key, action}, 0.0)
        new_q = old_q + alpha * (reward + gamma * next_best - old_q)
        updated = Map.put(q_table, {state_key, action}, new_q)

        if done do
          {:ok, updated}
        else
          step_loop(env, policy, next_state, updated, alpha, gamma, steps_left - 1, opts)
        end
      end
    end
  end

  defp max_next_q([], _q_table, _next_key), do: 0.0

  defp max_next_q(actions, q_table, next_key) do
    actions
    |> Enum.map(&Map.get(q_table, {next_key, &1}, 0.0))
    |> Enum.max(fn -> 0.0 end)
  end
end
