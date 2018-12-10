defmodule Payrix.Backend do
  @moduledoc false

  alias Payrix.Backend.Request
  alias HTTPoison.Error
  alias HTTPoison.Response

  @callback request(Request.t()) :: {:ok, Response.t()} | {:error, Error.t()}
end
