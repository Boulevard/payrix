use Mix.Config

config :payrix,
  backend: Payrix.Backend.Mock,
  api_key: "api_key",
  api_host: "https://test-api.splashpayments.com"
