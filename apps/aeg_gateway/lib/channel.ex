defmodule AegGateway.Channel do
  @moduledoc """
  Channel adapter behaviour (web, slack, whatsapp, etc).
  """

  @callback send_message(session_id :: String.t(), payload :: map(), opts :: keyword()) :: :ok | {:error, term()}
end
