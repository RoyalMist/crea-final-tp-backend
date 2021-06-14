defmodule CreaGraphy.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :body, :string
    belongs_to :user, CreaGraphy.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
  end
end
