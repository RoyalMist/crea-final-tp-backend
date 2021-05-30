import Config

#####################################################################
# Cloud
#####################################################################
master_ip = System.get_env("MASTER_IP") || "127.0.0.1"

config :crea_graphy,
  clustering: true,
  master_ip: master_ip

#####################################################################
# Database
#####################################################################
database_url =
  System.get_env("DB_URL") ||
    raise """
    environment variable DB_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

database_pool_size = String.to_integer(System.get_env("DB_POOL_SIZE") || "30")

config :crea_graphy, CreaGraphy.Repo,
  url: database_url,
  pool_size: database_pool_size

#####################################################################
# GraphQL API & FTP Link
#####################################################################
app_domain =
  System.get_env("APP_DOMAIN") ||
    raise """
    environment variable APP_DOMAIN is missing.
    For example: api.domain.com
    """

app_scheme = System.get_env("APP_SCHEME") || "https"

app_port = String.to_integer(System.get_env("APP_PORT") || "443")

secret_key =
  System.get_env("SECRET_KEY") ||
    raise """
    environment variable SECRET_KEY is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :crea_graphy, salt: secret_key

config :crea_graphy, CreaGraphyWeb.Endpoint,
  server: true,
  secret_key_base: secret_key,
  url: [host: "#{app_domain}", scheme: "#{app_scheme}", port: app_port],
  http: [
    port: 4000,
    transport_options: [socket_opts: [:inet6]]
  ]

#####################################################################
# Messaging
#####################################################################
config :crea_graphy, CreaCloud.Mail,
  relay: "127.0.0.1",
  port: 2525,
  ssl: false,
  tls: :never,
  auth: :never,
  retries: 2,
  no_mx_lookups: false,
  dkim: [
    s: "at",
    d: "alpchemist.com",
    private_key: {:pem_plain, File.read!("/opt/crea/private-key.pem")}
  ]
