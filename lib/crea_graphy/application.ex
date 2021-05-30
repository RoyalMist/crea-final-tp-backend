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

    children =
      if Application.get_env(:crea_graphy, CreaCloud.Mail) |> Keyword.fetch!(:adapter) ==
           Swoosh.Adapters.SMTP do
        children ++
          [
            %{
              id: :gen_smtp_server,
              start:
                {:gen_smtp_server, :start,
                 [
                   :smtp_server_example,
                   [
                     domain: Application.get_env(:crea_graphy, :domain),
                     address: {127, 0, 0, 1},
                     sessionoptions: [
                       allow_bare_newlines: :ignore,
                       hostname: Application.get_env(:crea_graphy, :domain),
                       callbackoptions: [relay: true]
                     ]
                   ]
                 ]}
            }
          ]
      else
        children
      end

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
