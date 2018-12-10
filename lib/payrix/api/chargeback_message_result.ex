defmodule Payrix.API.ChargebackMessageResult do
  @moduledoc false

  use Payrix.Resource,
    resource: "chargebackMessageResults",
    import: [:get, :query]
end
