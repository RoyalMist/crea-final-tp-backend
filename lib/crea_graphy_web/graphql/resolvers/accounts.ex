defmodule CreaGraphyWeb.Graphql.Resolvers.Accounts do
  @moduledoc false
  # def _NAME_(_, attrs, %{context: %{current_user: user}}) do
  #  case _CALL_(user, attrs) do
  #    {:error, changeset} ->
  #      {
  #        :error,
  #        %{
  #          message: "Reason",
  #          details: ChangesetErrors.error_details(changeset)
  #        }
  #      }
  #
  #    res ->
  #      res
  #  end
  # end

  def me(_, _, %{context: %{current_user: _user}}) do
    {:ok, %{id: 1}}
  end
end
