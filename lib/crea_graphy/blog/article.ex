defmodule CreaGraphy.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :body, :string
    field :tags, {:array, :string}
    field :title, :string
    belongs_to :user, CreaGraphy.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :tags, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
