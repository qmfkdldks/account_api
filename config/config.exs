# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :account_api, ecto_repos: [AccountCore.Repo]

# Configures the endpoint
config :account_api, AccountApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F87gcXtpHmLDsPb/bOzcHryIBNljmQoDFBaZnfoTc/j/jYQ7am75ISRtbRFZXqxU",
  render_errors: [view: AccountApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AccountApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :account_core, AccountCore.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("ACCOUNT_DB_USER"),
  password: System.get_env("ACCOUNT_DB_PASSWORD"),
  hostname: System.get_env("ACCOUNT_DB_HOST")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
