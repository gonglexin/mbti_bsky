import Config

config :mbti_bsky, MbtiBsky.Repo,
  database: "mbti_bsky_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :mbti_bsky, MbtiBskyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Zxjg4ftbgPAZI/cykZa+pQ97sZVbUPV/jAK8wyzWd2+159oUm73Kqzlea0HUf/BP",
  server: false

# In test we don't send emails
config :mbti_bsky, MbtiBsky.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true
