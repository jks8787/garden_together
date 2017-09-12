defmodule GardenTogether.Repo.Migrations.CreateGardens do
  use Ecto.Migration

  def change do
   create table(:gardens) do
     add :info, :string
     add :status, :string
     timestamps()
   end
  end
end
