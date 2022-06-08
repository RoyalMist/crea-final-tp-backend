import Config

if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :crea_graphy, CreaGraphyWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :crea_graphy, CreaGraphy.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host =
    System.get_env("PHX_HOST") ||
      raise """
      environment variable PHX_HOST is missing.
      For example: "example.com"
      """

  port = String.to_integer(System.get_env("PORT") || "4000")
  config :waffle, asset_host: System.get_env("CDN_URL") || "https://#{host}"

  config :cors_plug,
    origin: [
      "https://#{host}",
      "~r/https?.*creapi\d?\.*.*$/",
      "http://localhost",
      "http://127.0.0.1"
    ],
    max_age: 86_400

  config :crea_graphy, CreaGraphyWeb.Endpoint,
    secret_key_base: secret_key_base,
    url: [host: host, scheme: "https", port: 443],
    check_origin: false,
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ]
end
