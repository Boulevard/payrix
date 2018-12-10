defmodule Payrix.API.ChargebackMessage do
  @moduledoc false

  use Payrix.Resource,
    resource: "chargebackMessages",
    import: [:create, :get, :query]
end
