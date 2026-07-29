import Config

config :mbti_bsky, MbtiBsky.Repo,
  database: "mbti_bsky_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10

config :mbti_bsky, MbtiBskyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "RTLWCbU+u5G3BKC3b77oaJ9ejRzzBxGZVDV77SIKoOUnf7dbpdfjzczZbhlCjxfU",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:mbti_bsky, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:mbti_bsky, ~w(--watch)]}
  ]

# Enable dev routes for dashboard and mailbox
config :mbti_bsky, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :default_formatter, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Include debug annotations and locations in rendered markup.
  # Changing this configuration will require mix clean and a full recompile.
  debug_heex_annotations: true,
  debug_attributes: true,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
