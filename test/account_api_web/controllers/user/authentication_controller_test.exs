defmodule AccountApiWeb.User.AuthenticationControllerTest do
  use AccountApiWeb.ConnCase

  @create_attrs %{
    email: "liar009@gmail.com",
    password: "rkskekfk1",
    password_confirmation: "rkskekfk1"
  }

  @invalid_attrs %{email: "omm.com", password: "1323"}

  def fixture(:user) do
    {:ok, user} = AccountCore.Domain.User.sign_up(@create_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "Sign In POST /api/v1/user/auth" do
    setup [:create_user]

    test "it renders user jwt", %{conn: conn} do
      conn = post(conn, Routes.authentication_path(conn, :create), user: @create_attrs)
      assert json_response(conn, :ok)
    end

    test "email and password invalid format", %{conn: conn, user: user} do
      conn = post(conn, Routes.authentication_path(conn, :create), %{user: @invalid_attrs})
      assert json_response(conn, :unauthorized)["errors"] != %{}
    end
  end

end
