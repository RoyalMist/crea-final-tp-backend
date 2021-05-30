defmodule CreaGraphy.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text
      add :tags, {:array, :string}
      add :author, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:articles, [:author])
  end
end
