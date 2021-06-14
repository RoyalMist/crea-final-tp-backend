defmodule CreaGraphy.Repo.Migrations.DropUsersToken do
  use Ecto.Migration

  def change do
    drop table(:users_tokens)
  end
end
