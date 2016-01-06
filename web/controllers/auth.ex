defmodule Rumbl.Auth do
  import Plug.Conn

  # Take given options and extracate the keywords from the repository. If key does
  # not exist, error will be raised. Rumbl.Auth will always require the :repo option.
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  # call intentionally halts connection if there is no :user_id in the session
  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Rumbl.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
end