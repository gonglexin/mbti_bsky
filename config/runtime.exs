import Config

if System.get_env("PHX_SERVER") do
  config :mbti_bsky, MbtiBskyWeb.Endpoint, server: true
end

config :mbti_bsky, MbtiBskyWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT", "4000"))]

if config_env() == :dev do
  # Reload browser tabs when matching files change.
  config :mbti_bsky, MbtiBskyWeb.Endpoint,
    live_reload: [
      web_console_logger: true,
      patterns: [
        # Static assets, except user uploads
        ~r"priv/static/(?!uploads/).*\.(js|css|png|jpeg|jpg|gif|svg)$"E,
        # Gettext translations
        ~r"priv/gettext/.*\.po$"E,
        # Router, Controllers, LiveViews and LiveComponents
        ~r"lib/mbti_bsky_web/router\.ex$"E,
        ~r"lib/mbti_bsky_web/(controllers|live|components)/.*\.(ex|heex)$"E
      ]
    ]
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: postgresql://USER:PASS@HOST/DATABASE
      """

  # Fly.io Managed Postgres: the *.flympg.net hostnames resolve to IPv6-only
  # (AAAA records), so Postgrex must resolve over IPv6 to avoid :nxdomain.
  # `prepare: :unnamed` is required for PgBouncer in transaction pooling mode.
  config :mbti_bsky, MbtiBsky.Repo,
    url: database_url,
    socket_options: [:inet6],
    pool_size: 10,
    prepare: :unnamed
end

if config_env() == :prod do
  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"

  config :mbti_bsky, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :mbti_bsky, MbtiBskyWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0}
    ],
    secret_key_base: secret_key_base
end
