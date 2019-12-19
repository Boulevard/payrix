defmodule Payrix.API.OrgEntity do
  @moduledoc false

  use Payrix.Resource,
    resource: "orgEntities",
    import: [:create, :delete, :get, :query, :update]
end
