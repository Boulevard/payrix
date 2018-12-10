defmodule Payrix.Request do
  @moduledoc false

  @enforce_keys [
    :method,
    :url,
    :query,
    :body,
    :headers,
    :options
  ]

  # The request format is directly compatible with HTTPoison.
  @type t :: %__MODULE__{
          method: atom,
          url: binary,
          body: binary,
          query: Map.t(),
          headers: [{binary, binary}],
          options: Keyword.t()
        }

  defstruct @enforce_keys
end
