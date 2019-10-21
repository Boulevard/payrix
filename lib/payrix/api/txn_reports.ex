defmodule Payrix.API.TxnReports do
  @moduledoc false

  use Payrix.Resource,
    resource: "txnReports",
    import: [:get, :query]
end
