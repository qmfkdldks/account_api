defmodule AccountApiWeb.UserController do
  use AccountApiWeb, :controller

  alias Account.SDF
  alias Account.SDF.User

  action_fallback AccountApiWeb.FallbackController

  def index(conn, _params) do
    users = SDF.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- SDF.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = SDF.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = SDF.get_user!(id)

    with {:ok, %User{} = user} <- SDF.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = SDF.get_user!(id)

    with {:ok, %User{}} <- SDF.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
