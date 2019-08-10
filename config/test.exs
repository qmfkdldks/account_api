use Mix.Config

config :account_core, AccountCore.Guardian,
issuer: "account",
secret_key: "1Di0BLNANkPPqAbdcM60Gi2iuyPTvdZxtY8W5Apd3GfgeE/O8307J4qeEheoVQY6"

# Configure your database
config :account_core, AccountCore.Repo,
  username: "postgres",
  password: "postgres",
  database: "account_api_test",
  hostname: "localhost",
  port: 5432,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :account_api, AccountApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
