defmodule Payrix.API.Member do
  @moduledoc false

  use Payrix.Resource,
    resource: "members",
    import: [:create, :delete, :get, :query, :update]
end
