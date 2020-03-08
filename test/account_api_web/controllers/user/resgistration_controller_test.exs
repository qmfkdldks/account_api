defmodule AccountApiWeb.User.RegistrationControllerTest do
  use AccountApiWeb.ConnCase

  @email "test_user@gmail.com"
  @password "123Wjsdbstjs"

  @create_attrs %{
    email: @email,
    password: @password,
    password_confirmation: @password
  }

  @update_attrs %{
    email: @email,
    password: @password,
    password_confirmation: @password
  }

  @invalid_attrs %{email: "nil", password: "nil"}

  defp create(:user) do
    {:ok, user} = AccountCore.Domain.User.sign_up(@create_attrs)
    user
  end

  defp authenticate_user(%{conn: conn}) do
    user = create(:user)
    {:ok, token, _} = AccountCore.Domain.User.sign_in(user.email, user.password)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "bearer: " <> token)

    {:ok, %{conn: conn, user: user}}
  end

  describe "POST SignUp /api/v1/user" do
    test "valid user data", %{conn: conn} do
      response = post(conn, Routes.registration_path(conn, :create), user: @create_attrs)
      assert json_response(response, :created)
    end

    test "invalid user data", %{conn: conn} do
      response = post(conn, Routes.registration_path(conn, :create), user: @invalid_attrs)
      assert json_response(response, :unprocessable_entity)["errors"] != %{}
    end
  end

  describe "Put Update /api/v1/user" do
    setup [:authenticate_user]

    test "valid user data", %{conn: conn, user: user} do
      response =
        conn
        |> put(Routes.registration_path(conn, :update, user.id), user: @update_attrs)

      assert json_response(response, :ok)
    end

    test "invalid user data", %{conn: conn, user: user} do
      response = put(conn, Routes.registration_path(conn, :update, user.id), user: @invalid_attrs)
      assert json_response(response, :unprocessable_entity)["errors"] != %{}
    end

    test "invalid token", %{conn: conn, user: user} do
      response =
        conn
        |> put_req_header("authorization", "bearer: invalid")
        |> put(Routes.registration_path(conn, :update, user.id), user: @invalid_attrs)

      assert response(response, :unauthorized)
    end
  end
end
