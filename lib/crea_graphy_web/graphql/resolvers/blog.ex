defmodule CreaGraphyWeb.Graphql.Resolvers.Blog do
  @moduledoc false
  alias CreaGraphy.Blog
  alias CreaGraphyWeb.Graphql.Resolvers.ChangesetErrors

  def list(_, _, _) do
    {:ok, Blog.list_articles()}
  end
end
