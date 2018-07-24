defmodule Payrix.Backend.HTTPoison do
  @moduledoc false
  @behaviour Payrix.Backend
  alias Payrix.Request

  def request(request = %Request{}) do
    HTTPoison.request(
      request.method,
      request.url,
      request.body,
      request.headers,
      request.options
    )
  end
end
