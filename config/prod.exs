use Mix.Config

config :logger, level: :warn

config :cors_plug,
  origin: ["*"],
  max_age: 86_400,
  methods: ["GET", "POST"]
