defmodule Payrix.Backend.HTTPoison do
  @moduledoc false
  @behaviour Payrix.Backend

  alias Payrix.{
    Request,
    Query
  }

  def request(request = %Request{}) do
    url = if Map.size(request.query) > 0 do
      "#{request.url}?#{Query.encode(request.query)}"
    else
      request.url
    end

    HTTPoison.request(
      request.method,
      url,
      request.body,
      request.headers,
      request.options
    )
  end
end
