defmodule Payrix.API.AccountTest do
  use ExUnit.Case, async: false
  use Payrix.APICase

  alias Payrix.API.Account

  test "create/3 creates a record" do
    load_response("account/create.json") |> send_response
    assert {:ok, %{"id" => _}} = Account.create(%{foo: true})
    assert %{body: body} = take_request()
    assert String.contains?(to_string(body), "foo")
  end
end
