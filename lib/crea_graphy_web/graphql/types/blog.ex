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
      resolve(&Resolvers.Blog.list/2)
    end
  end

  object :blog_mutations do
    @desc "Create an article belonging to the logged in user"
    field :articles_create, :article do
      arg(:body, non_null(:string))
      arg(:tags, list_of(:string))
      arg(:title, non_null(:string))
      middleware(Authenticate)
      resolve(&Resolvers.Blog.create/2)
    end

    @desc "Update an article belonging to the logged in user"
    field :articles_update, :article do
      arg(:id, non_null(:id))
      arg(:body, :string)
      arg(:tags, list_of(:string))
      arg(:title, :string)
      middleware(Authenticate)
      resolve(&Resolvers.Blog.update/2)
    end

    @desc "Delete an article belonging to the logged in user"
    field :articles_delete, :article do
      arg(:id, non_null(:id))
      middleware(Authenticate)
      resolve(&Resolvers.Blog.delete/2)
    end
  end
end
