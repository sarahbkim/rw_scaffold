defmodule RealWorld.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :bio, :string
      add :email, :string
    end
  end
end
