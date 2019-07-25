defmodule AccountApiWeb.Router do
  use AccountApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AccountApiWeb do
    pipe_through :api
  end
end
