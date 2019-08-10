import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
auth_secret_key = System.fetch_env!("AUTH_SECRET_KEY")
app_port = System.fetch_env!("APP_PORT")
app_hostname = System.fetch_env!("APP_HOSTNAME")
db_user = System.fetch_env!("DB_USER")
db_password = System.fetch_env!("DB_PASSWORD")
db_host = System.fetch_env!("DB_HOST")
db_port = System.fetch_env!("DB_PORT")
db_name = System.get_env("DB_NAME")

config :account_api, AccountApiWeb.Endpoint,
  load_from_system_env: true,
  server: true,
  url: [host: db_host],
  secret_key_base: secret_key_base
# http: [:inet6, port: String.to_integer(db_port || "4000")],

config :account_api,
  app_port: app_port

config :account_api,
  app_hostname: app_hostname

# Configure your database
config :account_core, AccountCore.Repo,
  username: db_user,
  password: db_password,
  database: db_name,
  hostname: db_host,
  port: db_port,
  pool_size: 10

config :account_core, AccountCore.Guardian,
  issuer: "account_api",
  secret_key: auth_secret_key
