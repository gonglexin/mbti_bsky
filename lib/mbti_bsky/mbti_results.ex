defmodule MbtiBsky.MbtiResults do
  import Ecto.Query, warn: false
  alias MbtiBsky.Repo
  alias MbtiBsky.MbtiResult

  @doc """
  Gets a single MBTI result by handle.
  Returns `nil` if not found.
  """
  def get_by_handle(handle) do
    Repo.get_by(MbtiResult, handle: handle)
  end

  @doc """
  Gets a single MBTI result by handle.
  Raises `Ecto.NoResultsError` if not found.
  """
  def get_by_handle!(handle) do
    Repo.get_by!(MbtiResult, handle: handle)
  end

  @doc """
  Gets a MBTI result by handle if it exists and cache is valid.
  Returns `{:ok, mbti_result}` if found and valid, `{:error, :not_found}` otherwise.
  """
  def get_cached_by_handle(handle) do
    case get_by_handle(handle) do
      nil -> {:error, :not_found}
      mbti_result -> {:ok, mbti_result}
    end
  end

  @doc """
  Gets a MBTI result by handle only if the cache is valid (not expired).
  Returns `{:ok, mbti_result}` if found and cache is valid, `{:error, :expired}` if expired, or `{:error, :not_found}` if not found.
  """
  def get_valid_cached_by_handle(handle, hours \\ 24) do
    case get_by_handle(handle) do
      nil ->
        {:error, :not_found}

      mbti_result ->
        if MbtiResult.cache_valid?(mbti_result, hours) do
          {:ok, mbti_result}
        else
          {:error, :expired}
        end
    end
  end

  @doc """
  Creates or updates a MBTI result.
  If the handle already exists, it updates the record.
  """
  def create_or_update!(%{handle: handle} = attrs) do
    case get_by_handle(handle) do
      nil ->
        %MbtiResult{}
        |> MbtiResult.changeset(attrs)
        |> Repo.insert!()

      mbti_result ->
        mbti_result
        |> MbtiResult.changeset(attrs)
        |> Repo.update!()
    end
  end

  @doc """
  Creates or updates a MBTI result.
  Returns `{:ok, mbti_result}` on success, `{:error, changeset}` on failure.
  """
  def create_or_update(%{handle: handle} = attrs) do
    case get_by_handle(handle) do
      nil ->
        %MbtiResult{}
        |> MbtiResult.changeset(attrs)
        |> Repo.insert()

      mbti_result ->
        mbti_result
        |> MbtiResult.changeset(attrs)
        |> Repo.update()
    end
  end
end
