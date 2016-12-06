defmodule GraphQl.PostResolver do
  @moduledoc "Resolver for the `Post` field"

  alias GraphQl.{Repo,Post}

  def all(_args, _info) do
    {:ok, Repo.all(Post)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Post, id) do
      nil -> {:error, "Post with id #{id} not found"}
      post -> {:ok, post}
    end
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end

  @lint {Credo.Check.Refactor.PipeChainStart, false}
  def update(%{id: id, post: post_params}, _info) do
    Repo.get!(Post, id)
    |> Post.changeset(post_params)
    |> Repo.update
  end
end
