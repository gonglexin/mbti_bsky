defmodule MbtiBsky.Repo.Migrations.CreateMbtiResults do
  use Ecto.Migration

  def change do
    create table(:mbti_results) do
      add(:handle, :string, null: false)
      add(:mbti_type, :string, null: false)
      add(:result_data, :map, default: %{})

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:mbti_results, [:handle]))
  end
end
