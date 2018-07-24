defmodule Payrix.Resource do
  @moduledoc false

  @doc false
  defmacro __using__(options) do
    import_functions = options[:import] || []
    resource = Keyword.fetch!(options, :resource)

    quote bind_quoted: [import_functions: import_functions, resource: resource] do
      use Payrix.Endpoint, base_url: Payrix.base_url
      use Payrix.Endpoint.JSON
      alias Payrix.Token

      @resource resource

      if :query in import_functions do
        def query(options \\ []) do
          request(:get, "/#{@resource}")
          |> append_search(options)
          |> authorize_request(options)
          |> send_json_request
        end
      end

      if :get in import_functions do
        def get(id, options \\ []) when is_binary(id) do
          request(:get, "/#{@resource}/#{id}")
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.unwrap_singular_data()
        end
      end

      if :update in import_functions do
        def update(id, params, options \\ []) do
          request(:put, "/#{@resource}/#{id}", params)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.unwrap_singular_data()
        end
      end

      if :create in import_functions do
        def create(params, options \\ []) do
          request(:post, "/#{@resource}", params)
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.unwrap_singular_data()
        end
      end

      if :delete in import_functions do
        def delete(id, options \\ []) do
          request(:delete, "/#{@resource}/#{id}")
          |> authorize_request(options)
          |> send_json_request
          |> Payrix.Resource.unwrap_singular_data()
        end
      end
    end
  end

  def unwrap_singular_data({:ok, %{"response" => %{"data" => [data]}}}),
    do: {:ok, data}

  def unwrap_singular_data(response),
    do: response
end
