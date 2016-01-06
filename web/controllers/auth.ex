defmodule Rumbl.Auth do
  import Plug.Conn

  # Take given options and extracate the repository. If key does not exist, error
  # will be raised. Rumbl.Auth will always require the :repo option.
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Rumbl.User, user_id)
    assign(conn, :current_user, user)
  end
end