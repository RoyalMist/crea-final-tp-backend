defmodule CreaGraphy.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      CreaGraphy.Repo,
      CreaGraphyWeb.Telemetry,
      {Phoenix.PubSub, name: CreaGraphy.PubSub},
      CreaGraphyWeb.Endpoint
    ]

    start = Supervisor.start_link(children, strategy: :one_for_one, name: CreaGraphy.Supervisor)

    if Application.get_env(:crea_graphy, :auto_migrate, false) do
      CreaCloud.Db.migrate()
    end

    start
  end

  def config_change(changed, _new, removed) do
    CreaGraphyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
