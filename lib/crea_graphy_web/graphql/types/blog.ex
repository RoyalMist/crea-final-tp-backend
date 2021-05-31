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
    field(:user, :user)
  end

  object :blog_queries do
    @desc "List all articles"
    field :articles_list, list_of(:article) do
      resolve(&Resolvers.Blog.list/3)
    end
  end

  object :_NAME_mutations do
    @desc "Description"
    field :_NAME_, :_RETURN_TYPE_ do
      # resolve(&_RESOLVER_FUNCTION_/3)
    end
  end
end
