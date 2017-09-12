# require IEx;
defmodule GardenTogether.Area do
  @moduledoc """
  The Area context.
  """

  import Ecto.Query, warn: false
  alias GardenTogether.Repo

  alias GardenTogether.Area.{Comment, Garden}

  @doc """
  Returns the list of gardens.

  ## Examples

      iex> list_gardens()
      [%Garden{}, ...]

  """
  def list_gardens do
    Repo.all(Garden)
  end

  @doc """
  Gets a single garden.

  Raises `Ecto.NoResultsError` if the Garden does not exist.

  ## Examples

      iex> get_garden!(123)
      %Garden{}

      iex> get_garden!(456)
      ** (Ecto.NoResultsError)

  """
  def get_garden!(id), do: Repo.get!(Garden, id)

  @doc """
  Creates a garden.

  ## Examples

      iex> create_garden(user, %{field: value})
      {:ok, %Garden{}}

      iex> create_garden(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_garden(user, attrs \\ %{}) do
    GardenTogether.Area.GardenCreator.create_garden(user, attrs)
  end

  def create_comment(garden, user, attrs) do
    garden
    |> Ecto.build_assoc(:comments, %{user_id: user.id})
    |> Ecto.Changeset.cast(attrs, [:body])
    |> Ecto.Changeset.validate_required([:body])
    |> Repo.insert()
    |> case do
      {:ok, comment} ->
        {:ok, %{comment | user: user}}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def fetch_garden_comments(garden) do
    comments =
      from c in Comment,
        join: u in assoc(c, :user),
        order_by: c.inserted_at,
        preload: [user: u]
    Repo.preload(garden, [comments: comments])
  end

  @doc """
  Updates a garden.

  ## Examples

      iex> update_garden(garden, %{field: new_value})
      {:ok, %Garden{}}

      iex> update_garden(garden, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_garden(%Garden{} = garden, attrs) do
    # IEx.pry
    garden
    |> Garden.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Garden.

  ## Examples

      iex> delete_garden(garden)
      {:ok, %Garden{}}

      iex> delete_garden(garden)
      {:error, %Ecto.Changeset{}}

  """
  def delete_garden(%Garden{} = garden) do
    Repo.delete(garden)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking garden changes.

  ## Examples

      iex> change_garden(garden)
      %Ecto.Changeset{source: %Garden{}}

  """
  def change_garden(%Garden{} = garden) do
    Garden.changeset(garden, %{})
  end

  alias GardenTogether.Area.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end
end
