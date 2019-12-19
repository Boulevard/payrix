defmodule Payrix.API.Fee do
  @moduledoc false

  use Payrix.Resource,
    resource: "fees",
    import: [:create, :delete, :get, :query, :update]
end
