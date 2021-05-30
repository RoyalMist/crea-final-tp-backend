defmodule CreaGraphyWeb.Graphql.Types.Accounts do
  @moduledoc false
  use Absinthe.Schema.Notation
  alias CreaGraphyWeb.Graphql.Resolvers
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:name, :string)
  end

  object :accounts_queries do
    @desc "Fetch logged in user's profile"
    field :accounts_profile, :user do
      middleware(Authenticate)
      resolve(&Resolvers.Accounts.profile/3)
    end
  end

  object :accounts_mutations do
    @desc "Create a user account"
    field :accounts_signup, non_null(:string) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:name, non_null(:string))
      resolve(&Resolvers.Accounts.signup/3)
    end

    @desc "Sign in a user"
    field :accounts_signin, non_null(:string) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.signin/3)
    end

    @desc "Ask for a reset password link for the given email"
    field :accounts_ask_reset_password, non_null(:string) do
      arg(:email, non_null(:string))
      resolve(&Resolvers.Accounts.ask_reset_password_email/3)
    end

    @desc "Confirm a user's email with the provided token"
    field :accounts_confirm_email, non_null(:string) do
      arg(:token, non_null(:string))
      resolve(&Resolvers.Accounts.confirm_user_email/3)
    end

    @desc "Reset the password for the given token"
    field :accounts_reset_password, non_null(:string) do
      arg(:token, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))
      resolve(&Resolvers.Accounts.reset_password/3)
    end
  end
end
