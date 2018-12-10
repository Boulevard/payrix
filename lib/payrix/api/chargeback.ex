defmodule Payrix.API.Chargeback do
  @moduledoc false

  use Payrix.Resource,
    resource: "chargebacks",
    import: [:get, :query]
end
