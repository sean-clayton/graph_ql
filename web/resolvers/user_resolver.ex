defmodule GraphQl.UserResolver do
  @moduledoc "Resolver for `Users` field"

  alias GraphQl.{Repo,User,Session}

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end

  def login(params, _info) do
    with {:ok, user} <- Session.authenticate(params, Repo),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user, :access) do
      {:ok, %{token: jwt}}
    end
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
