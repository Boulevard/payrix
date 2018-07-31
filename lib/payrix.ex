defmodule Payrix do
  @moduledoc false

  @backend_config :backend
  @api_host_config :api_host
  @api_key_config :api_key

  def api_host do
    case get_env(@api_host_config) do
      api_host when is_binary(api_host) ->
        api_host

      nil ->
        raise_missing(@api_host_config)

      other ->
        raise_invalid(@api_host_config, other)
    end
  end

  def api_key do
    case get_env(@api_key_config) do
      api_key when is_binary(api_key) ->
        api_key

      nil ->
        raise_missing(@api_key_config)

      other ->
        raise_invalid(@api_key_config, other)
    end
  end

  def backend do
    case get_env(@backend_config, Payrix.Backend.HTTPoison) do
      backend when is_atom(backend) ->
        backend

      nil ->
        raise_missing(@backend_config)

      other ->
        raise_invalid(@backend_config, other)
    end
  end

  defp get_env(key, default \\ nil) do
    with {:system, var} <- Application.get_env(:payrix, key, default) do
      case System.get_env(var) do
        "true" -> true
        "false" -> false
        value -> value
      end
    end
  end

  defp raise_missing(key) do
    raise ArgumentError,
      message: """
      Payrix config #{inspect(key)} is required.
      """
  end

  defp raise_invalid(key, value) do
    raise ArgumentError,
      message: """
      Payrix config #{inspect(key)} is invalid, got: #{inspect(value)}
      """
  end
end
