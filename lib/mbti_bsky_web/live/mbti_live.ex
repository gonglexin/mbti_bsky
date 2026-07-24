defmodule MbtiBskyWeb.MbtiLive do
  use MbtiBskyWeb, :live_view

  alias MbtiBsky.{Ai, Bluesky, MbtiData, MbtiResults}
  alias Phoenix.LiveView.AsyncResult

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:handle, nil)
      |> assign(:result, AsyncResult.ok(nil))
      |> assign(:mbti_info, nil)
      |> assign(:share_url, nil)

    {:ok, socket}
  end

  def handle_event("analyse", %{"handle" => handle}, socket) when handle == "" do
    socket =
      socket
      |> put_flash(:error, "Please input the correct handle!")

    {:noreply, socket}
  end

  def handle_event("analyse", %{"handle" => handle}, socket) do
    socket =
      socket
      |> assign(:handle, handle)
      |> assign(:result, AsyncResult.loading())
      |> assign(:share_url, nil)
      |> start_async(:analysis, fn -> analyse(handle) end)

    {:noreply, socket}
  end

  def handle_async(:analysis, {:ok, result}, socket) do
    result =
      case result do
        {:ok, inner_result} -> inner_result
        _ -> result
      end

    mbti_info = MbtiData.get_type(result["type"])

    if mbti_info do
      MbtiResults.create_or_update!(%{
        handle: socket.assigns.handle,
        mbti_type: result["type"],
        result_data: result
      })

      {:noreply, push_navigate(socket, to: ~p"/result/#{socket.assigns.handle}")}
    else
      # AI could not determine a valid MBTI type — don't persist a placeholder row.
      reason = Map.get(result, "reason", "Could not determine an MBTI type from these posts.")

      socket =
        socket
        |> assign(:result, AsyncResult.ok(nil))
        |> assign(:mbti_info, nil)
        |> put_flash(:info, reason)

      {:noreply, socket}
    end
  end

  def handle_async(:analysis, {:exit, reason}, socket) do
    socket =
      socket
      |> assign(:result, AsyncResult.failed(reason, reason))

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

      e ->
        {:error, "Something wrong! #{inspect(e)}"}
    end
  end
end
