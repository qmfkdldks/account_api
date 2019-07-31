defmodule AccountApiWeb.User.AuthenticationController do
  use AccountApiWeb, :controller

  action_fallback AccountApiWeb.User.FallbackController

  alias AccountCore.Domain

  def create(conn, params) do
    %{"email" => email, "password" => password} = params["user"]
    with {:ok, token, _claims} <- Domain.User.sign_in(email, password) do
      render(conn, "jwt.json", jwt: token)
    end
  end
end
