defmodule AegRouter do
  @moduledoc """
  Provider routing with fallback and retry support.
  """

  @spec complete([module()], [map()], keyword()) :: {:ok, map()} | {:error, term()}
  def complete([], _messages, _opts), do: {:error, :no_provider_available}

  def complete([provider | rest], messages, opts) do
    retries = Keyword.get(opts, :provider_retries, 1)
    backoff_ms = Keyword.get(opts, :provider_backoff_ms, 150)

    case call_with_retry(provider, messages, opts, retries, backoff_ms) do
      {:ok, output} -> {:ok, Map.put(output, :provider, provider)}
      {:error, _reason} -> complete(rest, messages, opts)
    end
  end

  defp call_with_retry(provider, messages, opts, retries, backoff_ms) when retries > 0 do
    case provider.complete(messages, opts) do
      {:ok, _} = ok ->
        ok

      {:error, _reason} ->
        :timer.sleep(backoff_ms)
        call_with_retry(provider, messages, opts, retries - 1, backoff_ms * 2)

      unexpected ->
        {:error, {:invalid_provider_response, provider, unexpected}}
    end
  end

  defp call_with_retry(provider, _messages, _opts, 0, _backoff_ms) do
    {:error, {:provider_failed, provider}}
  end
end
