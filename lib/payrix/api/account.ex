defmodule Payrix.API.Account do
  @moduledoc false

  use Payrix.Resource,
    resource: "accounts",
    import: [:create, :delete, :get, :query, :update]
end
