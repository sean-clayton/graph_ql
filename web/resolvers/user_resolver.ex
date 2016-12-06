defmodule GraphQl.UserResolver do
  @moduledoc "Resolver for `Users` field"

  alias GraphQl.{Repo,User}

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end

  def update(%{id: id, user: user_params}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User with #{id} not found"}
      user -> user
              |> User.update_changeset(user_params)
              |> Repo.update
    end
  end

  def find(%{id: id}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User with id #{id} not found"}
      user -> {:ok, user}
    end
  end
end
