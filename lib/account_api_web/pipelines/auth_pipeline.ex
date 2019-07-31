defmodule Account.Guardian.AuthPipeline do
  # TODO check otp_app
  use Guardian.Plug.Pipeline, otp_app: :account_core,
  module: AccountCore.Guardian,
  error_handler: Account.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
