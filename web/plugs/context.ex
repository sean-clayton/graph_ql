defmodule GraphQl.Web.Context do
  @moduledoc false
  @behaviour Plug
 
  import Plug.Conn
  alias Guardian.{Plug}
 
  def init(opts), do: opts
 
  def call(conn, _) do
    case Plug.current_resource(conn) do
      nil -> conn
      user ->
        put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
