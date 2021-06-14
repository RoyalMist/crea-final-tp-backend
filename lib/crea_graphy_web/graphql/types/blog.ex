defmodule CreaGraphyWeb.Graphql.Types.Blog do
  @moduledoc false
  use Absinthe.Schema.Notation
  alias CreaGraphyWeb.Graphql.Resolvers
  alias CreaGraphyWeb.Graphql.Middlewares.Authenticate
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :article do
    field(:id, :id)
    field(:body, :string)
    field(:tags, list_of(:string))
    field(:title, :string)
    field(:user, :user, resolve: dataloader(Blog))
  end

  object :blog_queries do
    @desc "List all articles"
    field :articles_list, list_of(:article) do
      resolve(&Resolvers.Blog.list/3)
    end
  end

  object :blog_mutations do
    @desc "Create an article belonging to the logged in user"
    field :articles_create, :article do
      middleware(Authenticate)
      resolve(&Resolvers.Blog.create/3)
    end

    @desc "Create an article belonging to the logged in user"
    field :articles_update, :article do
      middleware(Authenticate)
      resolve(&Resolvers.Blog.update/3)
    end
  end
end
