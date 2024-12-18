defmodule MbtiBsky.Bluesky do
  @pds "https://bsky.social"

  def get_feeds_by_handle(handle) do
    session = create_session()

    response =
      BlueskyEx.Client.RecordManager.get_author_feed(session, actor: handle, limit: 100)

    body = response.body |> JSON.decode()

    case body do
      {:ok, %{"feed" => feed}} ->
        feeds =
          feed
          |> Enum.filter(fn %{"post" => %{"author" => %{"handle" => h}}} -> handle == h end)

        {:ok, feeds}

      {:ok, %{"message" => message}} ->
        {:error, message}
    end
  end

  def create_session() do
    creds = %BlueskyEx.Client.Credentials{
      username: System.get_env("BLUESKY_USERNAME"),
      password: System.get_env("BLUESKY_PASSWORD")
    }

    BlueskyEx.Client.Session.create(creds, @pds)
  end
end
