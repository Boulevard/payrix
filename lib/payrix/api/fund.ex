defmodule Payrix.API.Fund do
  @moduledoc false

  use Payrix.Resource,
    resource: "funds",
    import: [:get, :query]
end
