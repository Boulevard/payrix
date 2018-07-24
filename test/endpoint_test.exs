defmodule Payrix.EndpointTest do
  use ExUnit.Case, async: false
  use Payrix.APICase
  use Payrix.Endpoint, base_url: "http://localhost/"

  alias Payrix.Token
  alias Payrix.Request

  doctest Payrix.Endpoint

  test "request/5 creates a request with a base URL" do
    assert %Request{url: "http://localhost/" <> _} = request(:get, "foo")
  end

  test "authorize_request/2 signs with an APIKEY" do
    token = %Token{
      api_key: "api_key"
    }

    assert %Request{
      headers: [{"APIKEY", api_key}]
    } = request(:get, "foo") |> authorize_request(token)

    assert api_key == "api_key"
  end

  test "send_request/1 sends the request" do
    request = request(:get, "foo")
    send_request(request)
    assert take_request() == request
  end

  test "send_request/1 returns :ok for 2xx statuses" do
    http_200_response() |> send_response
    assert {:ok, _} = request(:get, "foo") |> send_request
  end

  test "send_request/1 returns :error for non-2xx statuses" do
    http_400_response() |> send_response
    assert {:error, _} = request(:get, "foo") |> send_request
  end
end
