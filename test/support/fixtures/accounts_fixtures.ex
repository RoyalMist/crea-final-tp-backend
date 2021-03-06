defmodule CreaGraphy.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CreaGraphy.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password(),
      name: "John Doe"
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> CreaGraphy.Accounts.register_user()

    user
  end

  def extract_user_token(url) do
    url
    |> String.split("/")
    |> Enum.reverse()
    |> hd()
  end
end
