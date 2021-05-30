use Mix.Config

config :logger, level: :info
config :crea_graphy, CreaCloud.Mail, adapter: Swoosh.Adapters.SMTP
