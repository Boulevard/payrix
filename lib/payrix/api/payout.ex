defmodule Payrix.API.Payout do
  @moduledoc false

  use Payrix.Resource,
    resource: "payouts",
    import: [:create, :delete, :get, :query, :update]
end
