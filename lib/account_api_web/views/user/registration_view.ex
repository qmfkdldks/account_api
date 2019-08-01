defmodule AccountApiWeb.User.RegistrationView do
  use AccountApiWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      pubg_id: user.pubg_id
    }
  end
end
