defmodule GraphQl.Router do
  use GraphQl.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug GraphQl.Web.Context
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GraphQl do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :graphql # Use GraphQL for the api 🤘

    forward "/", Absinthe.Plug,
      schema: GraphQl.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: GraphQl.Schema
  # Other scopes may use custom stacks.
  # scope "/api", GraphQl do
  #   pipe_through :api
  # end
end
