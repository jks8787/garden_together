defmodule GardenTogether.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1] # except can be used rather than only
  alias GardenTogether.UserManager.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true # this means it will not be saved by ecto
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do # this is for setting up specific functionlaity to a use case
    #fields = [:name, :email, :password, :password_confirmation]
    fields = ~w(name email password password_confirmation)a # ~w for a list of atoms ( as there is an a at the end)
    user
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> update_change(:email, &String.downcase/1) # |> update_change(:email, fn email -> String.downcase(email) end) with no capture syntax
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password, message: "must match password") # it knows by convention to look for password_confirmation
    |> unique_constraint(:email)
    |> maybe_hash_password()
  end

  # note you can write this `do: ` only for a single line of code otherwise use as keyword
  defp maybe_hash_password(%{valid?: true, changes: %{password: password}} = changeset),
    do: put_change(changeset, :password_hash, hashpwsalt(password))
  defp maybe_hash_password(changeset),
    do: changeset
# note
# run `User.registration_changeset(%User{}, %{name: "j", email: "j@j.com", password: "password", password_confirmation: "password"})`
# and you should get no errors
# also this is written using the aliases from from the .iex.exs file
end
