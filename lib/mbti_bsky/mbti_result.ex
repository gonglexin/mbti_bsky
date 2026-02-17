defmodule MbtiBsky.MbtiResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mbti_results" do
    field(:handle, :string)
    field(:mbti_type, :string)
    field(:result_data, :map)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mbti_result, attrs) do
    mbti_result
    |> cast(attrs, [:handle, :mbti_type, :result_data])
    |> validate_required([:handle, :mbti_type])
    |> unique_constraint(:handle)
  end

  @doc """
  Checks if the cache is still valid based on updated_at timestamp.
  Cache is valid for 24 hours.
  """
  def cache_valid?(mbti_result, hours \\ 24) do
    now = DateTime.utc_now()
    cache_expiry = DateTime.add(mbti_result.updated_at, hours * 3600, :second)
    DateTime.compare(now, cache_expiry) == :lt
  end
end
