defmodule Payrix.Endpoint do
  @moduledoc false

  alias HTTPoison.Response
  alias Payrix.Request
  alias Payrix.Query

  @default_using_options [api_host: ""]

  defmacro __using__(using_options \\ []) do
    merged_using_options = Keyword.merge(@default_using_options, using_options)

    quote do
      import unquote(__MODULE__),
        only: [
          apply_search: 2,
          apply_expand: 2,
          apply_pagination: 2,
          authorize_request: 2,
          send_request: 1
        ]

      @doc false
      def request(method, url, body \\ nil, headers \\ nil, options \\ nil) do
        api_host = unquote(merged_using_options)[:api_host]

        %Request{
          method: method,
          url: api_host <> url,
          query: %{},
          body: body || "",
          headers: headers || [],
          options: options || []
        }
      end
    end
  end

  def apply_expand(request = %Request{query: query}, options) do
    new_query =
      Keyword.take(options, [:expand])
      |> Enum.into(%{})

    %Request{request | query: Map.merge(query, new_query)}
  end

  def apply_pagination(request = %Request{query: query}, options) do
    new_query = %{
      page: %{
        number: Keyword.get(options, :page),
        limit: Keyword.get(options, :limit)
      }
    }

    %Request{request | query: Map.merge(query, new_query)}
  end

  def apply_search(request = %Request{headers: headers}, options) do
    with {:ok, search} <- Keyword.fetch(options, :search),
         encoded_search <- Query.encode(search),
         search_header <- {"SEARCH", encoded_search} do
      %Request{request | headers: [search_header | headers]}
    else
      _ -> request
    end
  end

  def authorize_request(request = %Request{headers: headers}, _options) do
    auth_header = {"APIKEY", Payrix.api_key()}
    %Request{request | headers: [auth_header | headers]}
  end

  def send_request(request = %Request{}) do
    with {:ok, response} <- Payrix.backend().request(request) do
      response
      |> parse_status()
    end
  end

  defp parse_status(response = %Response{status_code: c}) when c in 200..299 do
    {:ok, response}
  end

  defp parse_status(response = %Response{}) do
    {:error, response}
  end
end
