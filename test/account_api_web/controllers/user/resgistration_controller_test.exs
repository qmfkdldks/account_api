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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST SignUp /api/v1/user" do
    test "valid user data", %{conn: conn} do
      response = post(conn, Routes.registration_path(conn, :create), user: @create_attrs)

      # IO.inspect json_response(response, :created)
      assert json_response(response, :created)
    end

    test "invalid user data", %{conn: conn} do
      response = post(conn, Routes.registration_path(conn, :create), user: @invalid_attrs)
      assert json_response(response, :unprocessable_entity)["errors"] != %{}
    end
  end

end
