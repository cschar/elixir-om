defmodule Om.Application do
  use Application

  alias Om.Chatserver

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Om.Repo, []),
      # Start the endpoint when the application starts
      supervisor(OmWeb.Endpoint, []),
      # Start your own worker by calling: Om.Worker.start_link(arg1, arg2, arg3)
      # worker(Om.Worker, [arg1, arg2, arg3]),
    ]

    ### trying to use genserver...
    Chatserver.start_link
    Chatserver.add_message("foo")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Om.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OmWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
