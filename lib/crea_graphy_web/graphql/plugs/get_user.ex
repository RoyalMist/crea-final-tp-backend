defmodule CreaGraphyWeb.Graphql.Plugs.GetUser do
  @moduledoc false
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    Absinthe.Plug.put_options(conn, context: build_context(conn))
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- CreaGraphy.Accounts.get_user_by_session_token(token) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
