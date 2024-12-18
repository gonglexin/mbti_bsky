defmodule MbtiBskyWeb.MbtiLive do
  alias Phoenix.LiveView.AsyncResult
  alias MbtiBsky.Ai
  use MbtiBskyWeb, :live_view

  require Logger
  alias MbtiBsky.Bluesky

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_async(:result, fn -> {:ok, %{result: nil}} end)

    {:ok, socket}
  end

  def handle_event("analyse", %{"handle" => handle}, socket) do
    socket =
      socket
      |> assign(:result, AsyncResult.loading())
      |> assign_async(:result, fn -> {:ok, %{result: analyse(handle)}} end)

    {:noreply, socket}
  end

  defp analyse(handle) do
    {:ok, feeds} = Bluesky.get_feeds_by_handle(handle)

    all_post_texts =
      feeds
      |> Enum.map(fn %{"post" => %{"record" => %{"text" => text}}} -> text end)
      |> Enum.join("------------\n")

    {:ok, result} = Ai.analyse(all_post_texts)

    result
  end
end
