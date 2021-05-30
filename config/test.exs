import Config

config :crea_graphy, CreaGraphy.Repo,
  username: "postgres",
  password: "postgres",
  database: "crea_graphy_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :crea_graphy, CreaGraphyWeb.Endpoint,
  http: [port: 4002],
  server: false

config :crea_graphy, CreaCloud.Mail, adapter: Swoosh.Adapters.Test
config :bcrypt_elixir, :log_rounds, 1
config :logger, level: :warn
