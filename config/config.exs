# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :om,
  ecto_repos: [Om.Repo]

# Configures the endpoint
config :om, OmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a6gJX0UxvXl6r/JYqYOZA4vXTrJcD1gv7MzHAOY+SNU4j39GvhceduZ6NOG5W6j/",
  render_errors: [view: OmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Om.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Om.User,
  repo: Om.Repo,
  module: Om,
  web_module: OmWeb,
  router: OmWeb.Router,
  messages_backend: OmWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable],

  #https://github.com/smpallen99/coherence#phoenix-channel-authentication
  # for socket authentication
  user_token: true

config :coherence, OmWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
