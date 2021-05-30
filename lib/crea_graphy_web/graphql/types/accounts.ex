defmodule CreaGraphyWeb.Graphql.Types.Accounts do
  @moduledoc false
  use Absinthe.Schema.Notation
  alias CreaGraphyWeb.Graphql.Resolvers
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :user do
    field(:id, :id)
    field(:email, :string)
  end

  object :accounts_queries do
    @desc "Description"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end
  end

  # object :accounts_mutations do
  #  @desc "Description"
  #  field :_NAME_, :_RETURN_TYPE_ do
  #    # resolve(&_RESOLVER_FUNCTION_/3)
  #  end
  # end
  #
  # object :accounts_subscriptions do
  #  @desc "Description"
  #  field :_NAME_, :_RETURN_TYPE_ do
  #    # resolve(&_RESOLVER_FUNCTION_/3)
  #  end
  # end
end
