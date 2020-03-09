defmodule AccountApiWeb.User.RegistrationController do
  use AccountApiWeb, :controller

  alias AccountCore.Guardian
  alias AccountCore.{Domain}

  action_fallback AccountApiWeb.User.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Domain.User.sign_up(user_params),
         {:ok, _token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, user} <- Domain.User.update(user, user_params) do
      conn |> render("user.json", user: user)
    end
  end
end
