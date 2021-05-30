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

config :logger, level: :warn
