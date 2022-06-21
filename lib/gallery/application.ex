defmodule Gallery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GalleryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gallery.PubSub},
      # Start the Endpoint (http/https)
      GalleryWeb.Endpoint
      # Start a worker by calling: Gallery.Worker.start_link(arg)
      # {Gallery.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gallery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GalleryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
