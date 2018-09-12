defmodule Payrix.API.Token do
  @moduledoc false

  use Payrix.Resource,
    resource: "tokens",
    import: [:create, :get, :query, :update]
end
