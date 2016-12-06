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

  input_object :update_user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  input_object :update_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:integer)
  end

  mutation do
    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params

      resolve &UserResolver.update/2
    end

    field :create_post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :user_id, non_null(:integer)

      resolve &PostResolver.create/2
    end

    field :update_post, type: :post do
      arg :id, non_null(:integer)
      arg :post, :update_post_params

      resolve &PostResolver.update/2
    end

    field :delete_post, type: :post do
      arg :id, non_null(:integer)

      resolve &PostResolver.delete/2
    end
  end
end
