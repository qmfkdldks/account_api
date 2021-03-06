use Mix.Config

app_port = System.get_env("APP_PORT") || 4000
app_hostname = System.get_env("APP_HOSTNAME") || "localhost"
db_user = System.get_env("DB_USER") || "postgres"
db_password = System.get_env("DB_PASSWORD") || ""
db_host = System.get_env("DB_HOST") || "localhost"
db_port = System.get_env("DB_PORT") || 5432
db_name = System.get_env("DB_NAME") || "account_api_dev"

config :account_core, AccountCore.Repo,
  username: db_user,
  password: db_password,
  database: db_name,
  hostname: db_host,
  port: db_port,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :account_api, AccountApiWeb.Endpoint,
  url: [host: app_hostname],
  http: [port: app_port],
  secret_key_base: "F87gcXtpHmLDsPb/bOzcHryIBNljmQoDFBaZnfoTc/j/jYQ7am75ISRtbRFZXqxU",
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
