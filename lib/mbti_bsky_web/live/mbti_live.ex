defmodule MbtiBskyWeb.MbtiLive do
  use MbtiBskyWeb, :live_view

  alias MbtiBsky.{Ai, Bluesky, MbtiData}
  alias Phoenix.LiveView.AsyncResult

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:handle, nil)
      |> assign(:result, AsyncResult.ok(nil))
      |> assign(:mbti_info, nil)

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

    socket =
      socket
      |> assign(:result, AsyncResult.ok(result))
      |> assign(:mbti_info, mbti_info)

    {:noreply, socket}
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

  attr :label, :string, required: true
  attr :value, :string, required: true
  attr :is_ei, :boolean, default: false
  attr :is_sn, :boolean, default: false
  attr :is_tf, :boolean, default: false
  attr :is_jp, :boolean, default: false

  def dimension_card(assigns) do
    ~H"""
    <div class={[
      "bg-white dark:bg-gray-700 rounded-xl p-4 text-center shadow-sm",
      @is_ei && "border-l-4 border-indigo-500",
      @is_sn && "border-l-4 border-purple-500",
      @is_tf && "border-l-4 border-pink-500",
      @is_jp && "border-l-4 border-rose-500"
    ]}>
      <div class="text-2xl font-bold text-gray-400 dark:text-gray-500 mb-1">
        {@label}
      </div>
      <div class="text-sm md:text-base font-semibold text-gray-900 dark:text-white">
        {@value}
      </div>
    </div>
    """
  end

  slot :inner_block, required: true

  def trait_tag(assigns) do
    ~H"""
    <span class="inline-flex items-center px-3 py-1.5 rounded-lg bg-indigo-100 dark:bg-indigo-900/40 text-indigo-900 dark:text-indigo-200 text-sm font-medium">
      <.icon name="hero-sparkles" class="w-4 h-4 mr-1.5" />
      {render_slot(@inner_block)}
    </span>
    """
  end

  slot :inner_block, required: true

  def career_tag(assigns) do
    ~H"""
    <span class="inline-flex items-center px-4 py-2 rounded-lg bg-pink-100 dark:bg-pink-900/40 text-pink-900 dark:text-pink-200 text-sm font-medium">
      <.icon name="hero-briefcase" class="w-4 h-4 mr-1.5" />
      {render_slot(@inner_block)}
    </span>
    """
  end
end
