defmodule CreaGraphyWeb.Graphql.Resolvers.Accounts do
  alias CreaGraphy.Accounts
  alias CreaGraphyWeb.Graphql.Resolvers.ChangesetErrors

  def profile(_, _, %{context: %{current_user: user}}) do
    try do
      {:ok, Accounts.get_user!(user.id)}
    rescue
      _ -> {:error, "Invalid Token"}
    end
  end

  def signin(_, %{email: email, password: password}, _) do
    case Accounts.get_user_by_email_and_password(email, password) do
      nil ->
        {:error, "Invalid credentials!"}

      user ->
        token = Accounts.generate_user_session_token(user)
        {:ok, token}
    end
  end

  def signup(_, args, _) do
    case Accounts.register_user(args) do
      {:error, changeset} ->
        {
          :error,
          %{
            message: "Could not create account",
            details: ChangesetErrors.error_details(changeset)
          }
        }

      {:ok, user} ->
        token = Accounts.generate_user_session_token(user)
        {:ok, token}
    end
  end
end
