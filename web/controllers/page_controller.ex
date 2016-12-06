defmodule GraphQl.PageController do
  use GraphQl.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
