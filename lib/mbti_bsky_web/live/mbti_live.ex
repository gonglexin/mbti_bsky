defmodule MbtiBskyWeb.MbtiLive do
  alias Phoenix.LiveView.AsyncResult
  alias MbtiBsky.Ai
  use MbtiBskyWeb, :live_view

  require Logger
  alias MbtiBsky.Bluesky

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:handle, nil)
      |> assign_async(:result, fn -> {:ok, %{result: nil}} end)

    {:ok, socket}
  end

  def handle_event("analyse", %{"handle" => handle}, socket) do
    socket =
      socket
      |> assign(:handle, handle)
      |> assign(:result, AsyncResult.loading())
      |> assign_async(:result, fn ->
        case analyse(handle) do
          {:ok, result} ->
            {:ok, %{result: result}}

          {:error, message} ->
            {:error, message}
        end
      end)

    {:noreply, socket}
  end

  defp analyse(handle) do
    case Bluesky.get_feeds_by_handle(handle) do
      {:ok, feeds} ->
        all_post_texts =
          feeds
          |> Enum.map(fn %{"post" => %{"record" => %{"text" => text}}} -> text end)
          |> Enum.join("------------\n")

        Ai.analyse(all_post_texts)

      {:error, message} ->
        {:error, message}
    end
  end
end
