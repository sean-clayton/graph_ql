# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :graph_ql,
  ecto_repos: [GraphQl.Repo]

# Configures the endpoint
config :graph_ql, GraphQl.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mvKb03WjVdJ8Z1GEI2ISM/r7X2PFeCeDE0AAMrYyvyPYXmRUp2vrQfoBtJl7GYoU",
  render_errors: [view: GraphQl.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GraphQl.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT, # optional
  issuer: "GraphQl",
  ttl: {15, :minutes},
  verify_issuer: true, # optional
  secret_key: "mvKb03WjVdJ8Z1GEI2ISM/r7X2PFeCeDE0AAMrYyvyPYXmRUp2vrQfoBtJl7GYoU",
  serializer: GraphQl.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
