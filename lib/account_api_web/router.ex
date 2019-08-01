defmodule AccountApiWeb.Router do
  use AccountApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug AccountApiWeb.AuthPipeline
  end

  scope "/api/v1", AccountApiWeb do
    pipe_through :api

    scope "/user" do
      resources "/", User.RegistrationController, only: [:create]
      resources "/auth", User.AuthenticationController, only: [:create]
    end
  end

  scope "/api/v1", AccountApiWeb do
    pipe_through [:api, :authenticated]

    scope "/user" do
      resources "/", User.RegistrationController, only: [:show, :update]
    end
  end

end
