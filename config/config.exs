import Config

config :crea_graphy,
  ecto_repos: [CreaGraphy.Repo],
  generators: [binary_id: true]

config :crea_graphy, CreaGraphyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lXiIfECvO7quxTemKGnKr5AEkNMwBh/e6EvqoG1JY0MDHtumeElNAXrNAJ28j4aR",
  render_errors: [view: CreaGraphyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CreaGraphy.PubSub,
  live_view: [signing_salt: "FKp2vnac"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
