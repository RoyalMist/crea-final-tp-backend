defmodule CreaGraphy.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :body, :string
    field :tags, {:array, :string}
    field :title, :string
    field :author, :binary_id

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :tags])
    |> validate_required([:title, :body, :tags])
  end
end
