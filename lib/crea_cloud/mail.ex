defmodule CreaCloud.Mail do
  use Swoosh.Mailer, otp_app: :crea_graphy
  import Swoosh.Email
  alias CreaCloud.Mail.Welcome
  alias CreaCloud.Mail.ForgotPassword
  require Logger

  def welcome_email(opts) do
    new()
    |> to(opts[:email])
    |> from({"Crea", "contact@alpchemist.com"})
    |> subject("Bienvenue sur l'api CREA!")
    |> html_body(Welcome.render(opts))
    |> deliver
    |> log_mail()
  end

  def forgot_password_email(opts) do
    new()
    |> to(opts[:email])
    |> from({"Crea", "contact@alpchemist.com"})
    |> subject("Ton mot de passe.")
    |> html_body(ForgotPassword.render(opts))
    |> deliver
    |> log_mail()
  end

  def generate_template(file_path) do
    {:ok, template} =
      file_path
      |> File.read!()
      |> Mjml.to_html()

    ~r/{{\s*([^}^\s]+)\s*}}/
    |> Regex.replace(template, fn _, variable_name ->
      "<%= @#{variable_name} %>"
    end)
  end

  defp log_mail({:error, reason}) do
    Logger.warn("User notifier failed with: #{inspect(reason)}")
  end

  defp log_mail({:ok, response}), do: {:ok, response}
end
