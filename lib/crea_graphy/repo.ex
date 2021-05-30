defmodule CreaGraphy.Repo do
  use Ecto.Repo,
    otp_app: :crea_graphy,
    adapter: Ecto.Adapters.Postgres
end
