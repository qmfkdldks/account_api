use Mix.Config

# Configure your database
config :account_core, AccountCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "liar",
  password: "007rkdqm",
  database: "account_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :account_api, AccountApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

import_config "test.secret.exs"
