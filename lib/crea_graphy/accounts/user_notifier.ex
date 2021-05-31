defmodule CreaGraphy.Accounts.UserNotifier do
  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    Task.start(fn ->
      CreaCloud.Mail.welcome_email(
        email: user.email,
        name: user.name,
        url: url
      )
    end)

    "url/#{url}"
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    Task.start(fn ->
      CreaCloud.Mail.forgot_password_email(
        email: user.email,
        url: url
      )
    end)

    "url/#{url}"
  end
end
