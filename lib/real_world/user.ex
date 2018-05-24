defmodule RealWorld.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :bio, :string
    field :email, :string
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username, :bio, :email])
    |> validate_required([:username, :email])
  end
end

