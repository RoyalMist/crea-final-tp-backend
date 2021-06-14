defmodule CreaGraphyWeb.Graphql.Resolvers.Chat do
  @moduledoc false
  alias CreaGraphy.Chat
  alias CreaGraphyWeb.Graphql.Resolvers.ChangesetErrors

  def list(_, _) do
    {:ok, Chat.list_messages()}
  end

  def create(%{body: body}, %{context: %{current_user: user}}) do
    case Chat.create_message(%{user_id: user.id, body: body}) do
      {:error, changeset} ->
        {
          :error,
          %{
            message: "Impossible to post chat message",
            details: ChangesetErrors.error_details(changeset)
          }
        }

      res ->
        res
    end
  end
end
