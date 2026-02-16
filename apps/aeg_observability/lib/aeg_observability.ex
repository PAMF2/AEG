defmodule AegObservability do
  @moduledoc """
  Thin wrapper for instrumentation events.
  """

  @spec emit([atom()], map(), map()) :: :ok
  def emit(event_name, measurements \\ %{}, metadata \\ %{}) when is_list(event_name) do
    :telemetry.execute(event_name, measurements, metadata)
  end
end
