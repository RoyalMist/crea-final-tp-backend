defmodule CreaGraphyWeb.Graphql.Middlewares.Authenticate do
  @moduledoc false
  @behaviour Absinthe.Middleware

  def call(resolution, options) do
    case resolution.context do
      %{current_user: user} ->
        with_roles(resolution, user, options)

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Forbidden!"})
    end
  end

  defp with_roles(resolution, _, []) do
    resolution
  end

  defp with_roles(resolution, user, role) do
    if Atom.to_string(role) in user.roles do
      resolution
    else
      resolution |> Absinthe.Resolution.put_result({:error, "Forbidden!"})
    end
  end
end
