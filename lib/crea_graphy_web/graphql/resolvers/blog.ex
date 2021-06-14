defmodule CreaGraphyWeb.Graphql.Resolvers.Blog do
  @moduledoc false
  alias CreaGraphy.Blog
  alias CreaGraphyWeb.Graphql.Resolvers.ChangesetErrors

  def list(_, _, _) do
    {:ok, Blog.list_articles()}
  end

  def create(_, attrs, %{context: %{current_user: user}}) do
    case Blog.create_article(Map.merge(attrs, %{user_id: user.id})) do
      {:error, changeset} ->
        {
          :error,
          %{
            message: "Impossible to create article",
            details: ChangesetErrors.error_details(changeset)
          }
        }

      res ->
        res
    end
  end

  def update(_, attrs, %{context: %{current_user: user}}) do
    try do
      article = Blog.get_article!(attrs.id)

      if article.user_id != user.id do
        raise "forbidden"
      end

      case Blog.update_article(article, Map.merge(attrs, %{user_id: user.id})) do
        {:error, changeset} ->
          {
            :error,
            %{
              message: "Impossible to update article",
              details: ChangesetErrors.error_details(changeset)
            }
          }

        res ->
          res
      end
    catch
      e -> e
    end
  end
end
