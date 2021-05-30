defmodule CreaGraphyWeb.Graphql.Resolvers.Errors do
  @moduledoc false
  def error_details(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", stringify(value))
      end)
    end)
  end

  defp stringify([value]) do
    to_string(value)
  end

  defp stringify([_h | _t] = list) do
    list |> Enum.map(&to_string/1) |> Enum.reduce(&"#{&1}, #{&2}")
  end

  defp stringify(value) do
    to_string(value)
  end
end
