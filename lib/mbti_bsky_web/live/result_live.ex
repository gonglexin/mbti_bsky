defmodule MbtiBskyWeb.ResultLive do
  use MbtiBskyWeb, :live_view

  alias MbtiBsky.{Ai, Bluesky, MbtiData, MbtiResults}
  alias MbtiBsky.MbtiResult
  alias Phoenix.LiveView.AsyncResult

  def mount(%{"handle" => handle}, _session, socket) do
    socket =
      socket
      |> assign(:handle, handle)
      |> assign(:share_url, share_url(handle))
      |> assign(:result, AsyncResult.loading())
      |> assign(:mbti_info, nil)
      |> assign(:is_regenerating, false)
      |> assign(:is_expired, false)

    {:ok, socket}
  end

  def handle_params(%{"handle" => handle}, _uri, socket) do
    socket =
      socket
      |> assign(:handle, handle)
      |> assign(:share_url, share_url(handle))
      |> maybe_load_cached_result()

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("regenerate", _params, socket) do
    handle = socket.assigns.handle

    socket =
      socket
      |> assign(:is_regenerating, true)
      |> assign(:result, AsyncResult.loading())
      |> start_async(:analysis, fn -> analyse(handle) end)

    {:noreply, socket}
  end

  def handle_event("copy_share_url", _params, socket) do
    {:noreply, push_event(socket, "copy_url", %{url: socket.assigns.share_url})}
  end

  def handle_event("select_share_url", _params, socket) do
    {:noreply, push_event(socket, "select_input", %{id: "share-url"})}
  end

  def handle_event("copied_to_clipboard", _params, socket) do
    {:noreply, put_flash(socket, :info, "Link copied to clipboard!")}
  end

  def handle_async(:analysis, {:ok, {:ok, result}}, socket) do
    mbti_info = MbtiData.get_type(result["type"])

    if mbti_info do
      MbtiResults.create_or_update!(%{
        handle: socket.assigns.handle,
        mbti_type: result["type"],
        result_data: result
      })

      socket =
        socket
        |> assign(:result, AsyncResult.ok(result))
        |> assign(:mbti_info, mbti_info)
        |> assign(:is_regenerating, false)
        |> assign(:is_expired, false)
        |> put_flash(:info, "Result updated!")

      {:noreply, socket}
    else
      # AI could not determine a valid MBTI type — don't persist a placeholder row.
      reason = Map.get(result, "reason", "Could not determine an MBTI type from these posts.")

      socket =
        socket
        |> assign(:result, AsyncResult.ok(nil))
        |> assign(:mbti_info, nil)
        |> assign(:is_regenerating, false)
        |> put_flash(:info, reason)

      {:noreply, socket}
    end
  end

  def handle_async(:analysis, {:ok, {:error, reason}}, socket) do
    socket =
      socket
      |> assign(:result, AsyncResult.failed(reason, reason))
      |> assign(:is_regenerating, false)

    {:noreply, socket}
  end

  def handle_async(:analysis, {:exit, reason}, socket) do
    socket =
      socket
      |> assign(:result, AsyncResult.failed(reason, reason))
      |> assign(:is_regenerating, false)

    {:noreply, socket}
  end

  defp maybe_load_cached_result(socket) do
    handle = socket.assigns.handle

    case MbtiResults.get_cached_by_handle(handle) do
      {:ok, mbti_result} ->
        result = mbti_result.result_data
        mbti_info = MbtiData.get_type(result["type"])
        is_expired = !MbtiResult.cache_valid?(mbti_result)

        socket
        |> assign(:result, AsyncResult.ok(result))
        |> assign(:mbti_info, mbti_info)
        |> assign(:is_expired, is_expired)

      {:error, :not_found} ->
        socket
        |> assign(:result, AsyncResult.loading())
        |> start_async(:analysis, fn -> analyse(handle) end)
    end
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

  defp share_url(handle) do
    MbtiBskyWeb.Endpoint.url() <> ~p"/result/#{handle}"
  end
end
