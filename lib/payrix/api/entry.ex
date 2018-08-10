defmodule Payrix.API.Entry do
  @moduledoc false

  use Payrix.Resource,
    resource: "entries",
    import: [:get, :query]
end
