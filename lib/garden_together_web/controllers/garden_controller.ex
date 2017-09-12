defmodule GardenTogetherWeb.GardenController do
  use GardenTogetherWeb, :controller

  alias GardenTogether.Area
  alias GardenTogether.Area.{Comment, Garden}

  plug :authorize when action not in [:index, :show]

  def index(conn, _params) do
    gardens = Area.list_gardens()
    render(conn, "index.html", gardens: gardens)
  end

  def new(conn, _params) do
    comment = Area.change_comment(%Comment{})
    changeset = Area.change_garden(%Garden{comments: [comment]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"garden" => garden_params}) do
    case Area.create_garden(conn.assigns.current_user, garden_params) do
      {:ok, garden} ->
        conn
        |> put_flash(:info, "garden created successfully.")
        |> redirect(to: garden_path(conn, :show, garden))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    garden = Area.get_garden!(id)
    render(conn, "show.html", garden: garden)
  end

  def edit(conn, %{"id" => id}) do
    garden = Area.get_garden!(id)
    changeset = Area.change_garden(garden)
    render(conn, "edit.html", garden: garden, changeset: changeset)
  end

  def update(conn, %{"id" => id, "garden" => garden_params}) do
    garden = Area.get_garden!(id)

    case Area.update_garden(garden, garden_params) do
      {:ok, garden} ->
        conn
        |> put_flash(:info, "garden updated successfully.")
        |> redirect(to: garden_path(conn, :show, garden))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", garden: garden, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    garden = Area.get_garden!(id)
    {:ok, _garden} = Area.delete_garden(garden)

    conn
    |> put_flash(:info, "garden deleted successfully.")
    |> redirect(to: garden_path(conn, :index))
  end

  defp authorize(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to create or update gardens")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
