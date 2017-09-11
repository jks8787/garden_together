defmodule GardenTogetherWeb.RegistrationController do
  use GardenTogetherWeb, :controller # this is importing the init ect, to amek this controller a plug
  alias GardenTogether.UserManager
  alias UserManager.User

  def new(conn, _params) do
    # note you can use the asign function from plug if you want to
    changeset = User.registration_changeset(%User{}, %{})
    # here you can assign one item with render
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case UserManager.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "it works!")
        |> put_session(:current_user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

end
