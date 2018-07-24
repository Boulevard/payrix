defmodule Payrix.API.Merchant do
  @moduledoc false

  use Payrix.Resource,
    resource: "merchants",
    import: [:create, :delete, :get, :query, :update]
end
