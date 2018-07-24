defmodule Payrix.API.Txn do
  @moduledoc false

  use Payrix.Resource,
    resource: "txns",
    import: [:create, :get, :query, :update]
end
