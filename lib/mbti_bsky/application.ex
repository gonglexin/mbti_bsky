defmodule MbtiBsky.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MbtiBsky.Repo,
      MbtiBskyWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:mbti_bsky, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MbtiBsky.PubSub},
      MbtiBskyWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: MbtiBsky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    MbtiBskyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
