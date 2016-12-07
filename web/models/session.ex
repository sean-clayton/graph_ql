defmodule GraphQl.Session do
  @moduledoc false
  alias Comeonin.{Bcrypt}
  alias GraphQl.{User}

  def authenticate(params, repo) do
    user = repo.get_by(User, email: String.downcase(params.email))
    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Invalid login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
