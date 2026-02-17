defmodule MbtiBsky.Repo do
  use Ecto.Repo,
    otp_app: :mbti_bsky,
    adapter: Ecto.Adapters.Postgres
end
