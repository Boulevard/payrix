defmodule Payrix.API.ChargebackStatus do
  @moduledoc false

  use Payrix.Resource,
    resource: "chargebackStatuses",
    import: [:get, :query]
end
