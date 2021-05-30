use Mix.Config

config :logger, level: :warn
config :crea_graphy, CreaCloud.Mail, adapter: Swoosh.Adapters.SMTP
