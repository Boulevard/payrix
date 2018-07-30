defmodule Payrix.API.Disbursement do
  @moduledoc false

  use Payrix.Resource,
    resource: "disbursements",
    import: [:get, :query]
end
