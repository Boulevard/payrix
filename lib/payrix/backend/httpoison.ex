defmodule Payrix.Backend.HTTPoison do
  @moduledoc false
  @behaviour Payrix.Backend

  alias Payrix.{
    Request,
    Query
  }

  def request(request = %Request{}) do
    url =
      if Map.size(request.query) > 0 do
        "#{request.url}?#{Query.encode(request.query)}"
      else
        request.url
      end

    HTTPoison.request(
      request.method,
      url,
      request.body,
      request.headers,
      apply_default_options(request.options)
    )
  end

  defp apply_default_options(options) do
    options
    |> Keyword.put_new(:timeout, Payrix.httpoison_timeout())
    |> Keyword.put_new(:recv_timeout, Payrix.httpoison_timeout())
  end
end
