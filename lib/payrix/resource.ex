defmodule Payrix.Resource do
  @moduledoc false

  @doc false
  defmacro __using__(options) do
    import_functions = options[:import] || []
    resource = Keyword.fetch!(options, :resource)

    quote bind_quoted: [import_functions: import_functions, resource: resource] do
      use Payrix.Endpoint, api_host: Payrix.api_host()
      use Payrix.Endpoint.JSON

      alias Payrix.{
        Token
      }

      @resource resource

      if :query in import_functions do
        def query(options \\ []) do
          request(:get, "/#{@resource}")
          |> apply_search(options)
          |> apply_expand(options)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.parse_response()
        end

        def stream_query(options \\ []) do
          request(:get, "/#{@resource}")
          |> apply_search(options)
          |> apply_expand(options)
          |> authorize_request(options)
          |> Payrix.Stream.from_request(options, &send_json_request/1)
        end
      end

      if :get in import_functions do
        def get(id, options \\ []) when is_binary(id) do
          request(:get, "/#{@resource}/#{id}")
          |> apply_expand(options)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.parse_response()
        end
      end

      if :update in import_functions do
        def update(id, params, options \\ []) do
          request(:put, "/#{@resource}/#{id}", params)
          |> apply_expand(options)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.parse_response()
        end
      end

      if :create in import_functions do
        def create(params, options \\ []) do
          request(:post, "/#{@resource}", params)
          |> apply_expand(options)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.parse_response()
        end
      end

      if :delete in import_functions do
        def delete(id, options \\ []) do
          request(:delete, "/#{@resource}/#{id}")
          |> apply_expand(options)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.parse_response()
        end
      end
    end
  end

  def parse_response({:ok, %{"response" => json}}) do
    response = %Payrix.Response{
      data: json["data"],
      errors: json["errors"],
      details: json["details"]
    }

    {:ok, response}
  end

  def parse_response(other), do: other
end
