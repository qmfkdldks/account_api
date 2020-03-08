defmodule AccountApiWeb.AuthErrorHandler do
  @moduledoc "Define how to handle when user authentication failed"
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{error: to_string(type)})
    send_resp(conn, 401, body)
  end
end
