# require IEx;
defmodule GardenTogether.Area.GardenCreator do
  import Ecto.Changeset
  alias GardenTogether.{Repo, Area}

  def create_garden(user, attrs) do
    %Area.Garden{}
    |> garden_changeset(user, attrs)
    |> Repo.insert()
  end

  defp garden_changeset(garden, user, attrs) do
    garden
    |> cast(attrs, [:info])
    |> validate_required([:info])
    |> put_change(:status, "open")
    |> put_assoc(:comments, [comment_changeset(user, attrs)])
  end

  defp comment_changeset(user, attrs) do
    # IEx.pry
    %Area.Comment{}
    |> cast(attrs, [:body])
    |> validate_required([:body])
    |> put_assoc(:user, user)
  end
end
