defmodule Payrix.API.EntityTest do
  use ExUnit.Case, async: false
  use Payrix.APICase

  alias Payrix.API.Entity

  test "create/3 creates a record" do
    load_response("entity/create.json") |> send_response
    assert {:ok, %{"id" => _}} = Entity.create(%{foo: true})
    assert %{body: body} = take_request()
    assert String.contains?(to_string(body), "foo")
  end
end
