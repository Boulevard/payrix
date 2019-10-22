defmodule Payrix.API.TxnReport do
  @moduledoc false

  use Payrix.Resource,
    resource: "txnReports",
    import: [:get, :query]
end
