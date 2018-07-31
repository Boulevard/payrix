defmodule Payrix.Stream do
  @moduledoc false

  def from_request(request, options, send_func) do
    Stream.resource(
      fn -> start_stream(options) end,
      fn acc -> next(request, send_func, acc) end,
      &after_stream/1
    )
  end

  defp start_stream(options) do
    [
      limit: Keyword.get(options, :per_page, 100),
      page: 1,
      finished: false
    ]
  end

  defp next(request, send_func, options) do
    if Keyword.get(options, :finished) do
      {:halt, options}
    else
      fetch_next_page(request, send_func, options)
    end
  end

  defp fetch_next_page(request, send_func, options) do
    request
    |> Payrix.Endpoint.apply_pagination(options)
    |> send_func.()
    |> case do
      {:ok, %{"response" => json}} ->
        page = %Payrix.Response{
          data: json["data"],
          errors: json["errors"],
          details: json["details"]
        }

        options =
          options
          |> Keyword.update!(:page, &(&1 + 1))
          |> Keyword.put(:finished, !get_in(json, ["details", "page", "hasMore"]))

        {[page], options}

      other ->
        {:halt, other}
    end
  end

  defp after_stream(_options) do
    :ok
  end
end
