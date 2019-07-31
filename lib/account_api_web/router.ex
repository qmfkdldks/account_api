defmodule AccountApiWeb.Router do
  use AccountApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Account.Guardian.AuthPipeline
  end

  scope "/api/v1", AccountApiWeb do
    pipe_through :api

    scope "/user" do
      resources "/", User.RegistrationController, only: [:create]
      resources "/auth", User.AuthenticationController, only: [:create]
    end
  end

  scope "/api/v1", AccountApiWeb do
    pipe_through [:api, :jwt_authenticated]

    scope "/user" do
      resources "/", User.RegistrationController, only: [:show]
    end
  end

end
