defmodule Payrix.API.Entity do
  @moduledoc false

  use Payrix.Resource,
    resource: "entities",
    import: [:create, :delete, :get, :query, :update]
end
