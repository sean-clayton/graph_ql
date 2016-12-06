defmodule GraphQl.User do
  @moduledoc "The User model"
  use GraphQl.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    has_many :posts, GraphQl.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end
end
