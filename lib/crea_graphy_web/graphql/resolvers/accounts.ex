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
        Accounts.deliver_email_confirmation_instructions(user)
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
        Accounts.deliver_email_confirmation_instructions(user)
        {:ok, token}
    end
  end

  def confirm_user(_, %{token: token}, _) do
    case Accounts.confirm_user(token) do
      {:ok, _} ->
        {:ok, "Email validated"}

      :error ->
        {:error, "Invalid Token"}
    end
  end

  def ask_reset_password_email(_, %{email: email}, _) do
    user = Accounts.get_user_by_email(email)

    if user != nil do
      Accounts.deliver_user_reset_password_instructions(user)
    end

    {:ok, "If user email is known an email will be sent with instructions"}
  end

  def reset_password(
        _,
        %{token: token, password: password, password_confirmation: password_confirmation},
        _
      ) do
    case Accounts.get_user_by_reset_password_token(token) do
      nil ->
        {:error, "Invalid Token"}

      user ->
        case Accounts.reset_user_password(user, %{
               password: password,
               password_confirmation: password_confirmation
             }) do
          {:ok, _} ->
            {:ok, "Password reset successful"}

          {:error, changeset} ->
            {
              :error,
              %{
                message: "Could not reset password",
                details: ChangesetErrors.error_details(changeset)
              }
            }
        end
    end
  end
end
