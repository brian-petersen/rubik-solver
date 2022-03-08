defmodule RubikSolver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # NOTE disabling Repo since its not
      # needed for initial phases of development
      # RubikSolver.Repo,
      # Start the Telemetry supervisor
      RubikSolverWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RubikSolver.PubSub},
      # Start the Endpoint (http/https)
      RubikSolverWeb.Endpoint
      # Start a worker by calling: RubikSolver.Worker.start_link(arg)
      # {RubikSolver.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RubikSolver.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RubikSolverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
