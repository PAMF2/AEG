defmodule AegObservability.RuntimeEvents do
  @moduledoc false

  def run_started(meta), do: AegObservability.emit([:aeg, :runtime, :run, :started], %{}, meta)

  def run_finished(duration_ms, meta) do
    AegObservability.emit([:aeg, :runtime, :run, :finished], %{duration_ms: duration_ms}, meta)
  end
end
