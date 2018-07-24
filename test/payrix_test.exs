defmodule PayrixTest do
  use ExUnit.Case
  doctest Payrix

  setup do
    old_env = get_all_env()
    # old_system_env = System.get_env

    on_exit fn ->
      restore_env(old_env)
      # restore_system_env(old_system_env)
    end
  end

  test "backend/0 returns the right module" do
    put_env(:backend, AnyModuleName)
    assert Payrix.backend == AnyModuleName
  end

  defp get_all_env do
    Application.get_all_env(:payrix)
  end

  defp restore_env(old_env) do
    new_env = get_all_env()

    for {k, _} <- new_env, do: delete_env(k)
    for {k, v} <- old_env, do: put_env(k, v)

    keyword_list_equal?(get_all_env(), old_env) || raise """
    Could not restore the application's environment. Check that you're not
    modifying it simultaneously in other tests. Those tests should specify
    `async: false`.
    """
  end

  defp keyword_list_equal?(env1, env2) do
    List.keysort(env1, 1) == List.keysort(env2, 1)
  end

  defp delete_env(key) do
    Application.delete_env(:payrix, key)
  end

  defp put_env(key, value) do
    Application.put_env(:payrix, key, value)
  end
end
