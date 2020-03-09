defmodule AccountApiWeb.AuthPipeline do
  @moduledoc "authenticated pipeline is executed for the protected routes"
  use Guardian.Plug.Pipeline,
    otp_app: :account_core,
    module: AccountCore.Guardian,
    error_handler: AccountApiWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
