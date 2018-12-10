defmodule Payrix.API.ChargebackDocument do
  @moduledoc false

  use Payrix.Resource,
    resource: "chargebackDocuments",
    import: [:create, :delete, :get, :query, :update]
end
