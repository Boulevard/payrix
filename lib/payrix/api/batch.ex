defmodule Payrix.API.Batch do
  @moduledoc false

  use Payrix.Resource,
    resource: "batches",
    import: [:create, :get, :query, :update]
end
