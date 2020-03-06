use Mix.Config

app_port = System.get_env("APP_PORT") || 4002
app_hostname = System.get_env("APP_HOSTNAME") || "localhost"
db_user = System.get_env("DB_USER") || "postgres"
db_password = System.get_env("DB_PASSWORD") || "postgres"
db_host = System.get_env("DB_HOST") || "localhost"
db_port = System.get_env("DB_PORT") || 5432
db_name = System.get_env("DB_NAME") || "account_api_test"

config :account_core, AccountCore.Guardian,
issuer: "account",
secret_key: "1Di0BLNANkPPqAbdcM60Gi2iuyPTvdZxtY8W5Apd3GfgeE/O8307J4qeEheoVQY6"

# Configure your database
config :account_core, AccountCore.Repo,
  username: db_user,
  password: db_password,
  database: db_name,
  hostname: db_host,
  port: db_port,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :account_api, AccountApiWeb.Endpoint,
  http: [port: app_port],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
