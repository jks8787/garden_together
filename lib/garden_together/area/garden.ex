defmodule GardenTogether.Area.Garden do
  use Ecto.Schema
  import Ecto.Changeset
  alias GardenTogether.Area.{Garden, Comment}


  schema "gardens" do
    field :status, :string
    field :info, :string
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(%Garden{} = garden, attrs) do
    garden
    |> cast(attrs, [:info, :status])
    |> validate_required([:info, :status])
  end
end
