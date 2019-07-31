defmodule AccountApiWeb.User.AuthenticationView do
  use AccountApiWeb, :view

  def render("create.json", response) do
    response
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
