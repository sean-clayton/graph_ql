defmodule GraphQl.Schema do
  @moduledoc "Defines GraphQL schema things"

  use Absinthe.Schema
  import_types GraphQl.Schema.Types
  alias GraphQl.{PostResolver,UserResolver}

  query do
    @desc "Get all posts"
    field :posts, list_of(:post) do
      resolve &PostResolver.all/2
    end

    @desc "Get a post by ID"
    field :post, type: :post do
      arg :id, non_null(:id)
      resolve &PostResolver.find/2
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &UserResolver.all/2
    end

    @desc "Get a user by ID"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &UserResolver.find/2
    end
  end
end
