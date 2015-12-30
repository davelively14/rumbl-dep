defmodule Rumbl.UserView do
  use Rumbl.Web, :view

  alias Rumble.User

  # Splits frist name from last, returns only first name
  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end