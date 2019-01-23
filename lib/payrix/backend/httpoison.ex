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

    options =
      request.options
      |> merge_httpoison_options(request)
      |> apply_default_options()

    HTTPoison.request(
      request.method,
      url,
      request.body,
      request.headers,
      options
    )
  end

  defp apply_default_options(options) do
    options
    |> Keyword.put_new(:timeout, Payrix.httpoison_timeout())
    |> Keyword.put_new(:recv_timeout, Payrix.httpoison_timeout())
  end

  defp merge_httpoison_options(options, %{httpoison_options: httpoison_options})
       when is_list(httpoison_options) do
    Keyword.merge(options, httpoison_options)
  end

  defp merge_httpoison_options(options, _), do: options
end
