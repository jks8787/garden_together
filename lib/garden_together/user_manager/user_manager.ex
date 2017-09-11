defmodule GardenTogether.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias GardenTogether.Repo

  alias GardenTogether.UserManager.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id), do: Repo.get!(User, id)

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs \\ %{}) do # here there is a default of an empty struct as the attributes
    %User{}
    |> User.registration_changeset(attrs) # apply the change set
    |> Repo.insert() # insert it
    # note - with aliases now can run
    # `UserManager.register_user(%{name: "j", email: "j@j.com", password: "password", password_confirmation: "password"})`
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  authenticates a user

  ## Examples

      iex> #some code here

  """
  def authenticate_with_email_and_password(email, password) do
    # with allows you to avoid nested cases
    with %User{password_hash: hash} = user <- Repo.get_by(User, email: email),
         true <- Comeonin.Bcrypt.checkpw(password, hash) do
      {:ok, user}
    else
      # nil ->
      #   {:error, :unauthorized}
      # false ->
      #   {:error, :unauthorized}

      # this is best so that nothing is shown to the user
      _ ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :unauthorized}
    end
  end
end
