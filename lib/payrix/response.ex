defmodule Payrix.Response do
  @moduledoc false

  @enforce_keys [
    :data,
    :errors,
    :details
  ]

  @type t :: %__MODULE__{
          data: [any],
          errors: [any],
          details: Map.t()
        }

  defstruct @enforce_keys
end
