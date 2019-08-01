defmodule AccountApiWeb.User.RegistrationControllerTest do
  use AccountApiWeb.ConnCase

  @create_attrs %{
    email: "some@naver.com",
    password: "rkskekfk1",
    password_confirmation: "rkskekfk1"
  }

  @update_attrs %{
    email: "some@naver.com",
    password: "rkskekfk1",
    password_confirmation: "rkskekfk1"
  }

  @invalid_attrs %{email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = AccountCore.Domain.User.sign_up(@create_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  setup %{conn: conn} do
    user = fixture(:user)
    {:ok, token, _} = AccountCore.Domain.User.sign_in(user.email, user.password)

    conn = conn
       |> put_req_header("accept", "application/json")
       |> put_req_header("Bearer", token)

    {:ok, %{ conn: conn, user: user }}
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

    test "valid user data", %{conn: conn, user: user} do
      response = conn
        |> put(Routes.registration_path(conn, :update, user.id), user: @update_attrs)
      assert json_response(response, :ok)
    end

    test "invalid user data", %{conn: conn, user: user} do
      response = put(conn, Routes.registration_path(conn, :update, user.id), user: @invalid_attrs)
      assert json_response(response, :unprocessable_entity)["errors"] != %{}
    end

    test "unauthorized", %{conn: conn, user: user} do
      response = put(conn, Routes.registration_path(conn, :update, user.id), user: @invalid_attrs)
      assert json_response(response, :unauthorized)["errors"] != %{}
    end
  end

end
