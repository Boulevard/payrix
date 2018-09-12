defmodule Payrix.API.Assessment do
  @moduledoc false

  use Payrix.Resource,
    resource: "assessments",
    import: [:get, :query]
end
