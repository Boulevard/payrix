use Mix.Config

config :payrix,
  backend: Payrix.Backend.Mock,
  use_production_api: true,
  api_key: "api_key"
