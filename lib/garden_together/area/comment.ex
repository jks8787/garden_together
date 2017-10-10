
defmodule GardenTogether.Area.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias GardenTogether.Area.{Garden, Comment}
  alias GardenTogether.UserManager.User

  schema "comments" do
    field :body, :string

    belongs_to :garden, Garden
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
