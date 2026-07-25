defmodule MbtiBskyWeb.MbtiComponents do
  @moduledoc """
  MBTI display primitives.

  The 11 components here are the single source of truth for how MBTI content
  is rendered. Every value traces to a token defined in DESIGN.md §2–§4 and
  exposed through `assets/css/app.css` `@theme`. A unified brand accent flows
  through the global `--type-accent` custom property so every type renders
  consistently without hard-coded classes.

  Refer to DESIGN.md §5 for the primitive inventory.
  """

  use Phoenix.Component
  import MbtiBskyWeb.CoreComponents, only: [icon: 1]

  # Trait word -> pole letter. Data values use person nouns ("Introvert")
  # but the 4-letter type uses pole letters; this resolves the gap.
  @trait_to_letter %{
    "Extravert" => "E",
    "Introvert" => "I",
    "Sensing" => "S",
    "Intuitive" => "N",
    "Thinking" => "T",
    "Feeling" => "F",
    "Judging" => "J",
    "Perceiving" => "P"
  }

  # Fixed display order + metadata for the four cognitive-function axes.
  @dimension_axes [
    {"E/I", "Energy", "Extraversion", "Introversion"},
    {"S/N", "Information", "Sensing", "Intuition"},
    {"T/F", "Decisions", "Thinking", "Feeling"},
    {"J/P", "Lifestyle", "Judging", "Perceiving"}
  ]

  # ---------------------------------------------------------------------------
  # 1. type_hero
  # ---------------------------------------------------------------------------

  @doc """
  Renders the large MBTI type centerpiece: group label, 4-letter type,
  type name, description, and an ambient accent orb. Uses the global
  `--type-accent` brand color.
  """
  attr :id, :string, default: "type-hero"
  attr :type, :string, required: true
  attr :type_name, :string, required: true
  attr :group_label, :string, required: true
  attr :description, :string, required: true

  def type_hero(assigns) do
    ~H"""
    <section
      id={@id}
      class="relative overflow-hidden rounded-xl border border-border bg-surface-2 p-8 md:p-16 text-center"
    >
      <div
        aria-hidden="true"
        class="pointer-events-none absolute left-1/2 top-1/2 size-64 md:size-80 -translate-x-1/2 -translate-y-1/2 rounded-full opacity-60 blur-3xl animate-orb-bloom"
        style="background: radial-gradient(circle, var(--type-accent), transparent 70%)"
      />
      <div class="relative">
        <p class="mb-4 text-badge font-bold uppercase tracking-[0.25em] text-[var(--type-accent)]">
          {@group_label}
        </p>
        <h2
          id={"#{@id}-letters"}
          class="font-display text-type-name font-bold leading-none tracking-tight text-text"
          data-type-letters={@type}
          phx-hook="TypeReveal"
        >
          <%= for letter <- String.graphemes(@type) do %>
            <span class="inline-block">{letter}</span>
          <% end %>
        </h2>
        <p class="mt-3 font-display text-h3 text-text-muted">{@type_name}</p>
        <p class="mx-auto mt-6 max-w-2xl text-body-l text-text-muted">{@description}</p>
      </div>
    </section>
    """
  end

  # ---------------------------------------------------------------------------
  # 2. dimension_grid
  # ---------------------------------------------------------------------------

  @doc """
  Renders the four cognitive-function axis cards from a `dimensions` map
  shaped like `%{"E/I" => "Introvert", ...}` (the winning trait word).
  The winning pole is highlighted with the global accent.
  """
  attr :id, :string, default: "dimension-grid"
  attr :dimensions, :map, required: true

  def dimension_grid(assigns) do
    assigns = assign(assigns, :axes, @dimension_axes)

    ~H"""
    <div id={@id} class="grid grid-cols-1 gap-4 sm:grid-cols-2">
      <.dimension_card
        :for={{axis, label, left, right} <- @axes}
        axis={axis}
        label={label}
        left_pole={left}
        right_pole={right}
        winning_value={Map.get(@dimensions, axis)}
      />
    </div>
    """
  end

  attr :axis, :string, required: true
  attr :label, :string, required: true
  attr :left_pole, :string, required: true
  attr :right_pole, :string, required: true
  attr :winning_value, :string, default: nil

  defp dimension_card(assigns) do
    ~H"""
    <div class="group rounded-lg border border-border bg-surface-2 p-5 transition-all duration-200 hover:-translate-y-0.5 hover:border-border-strong hover:shadow-default">
      <div class="flex items-center justify-between">
        <span class="font-display text-base font-bold tracking-[0.2em] text-text-faint">{@axis}</span>
        <span class="text-small text-text-faint">{@label}</span>
      </div>
      <div class="mt-4 flex items-center gap-3">
        <span class={[
          "flex size-9 items-center justify-center rounded-md font-display text-base font-bold transition-colors",
          @winning_value && winning_letter(@winning_value) == String.at(@axis, 0) &&
            "bg-[var(--type-accent)] text-canvas",
          @winning_value && winning_letter(@winning_value) != String.at(@axis, 0) &&
            "bg-surface text-text-faint"
        ]}>
          {String.at(@axis, 0)}
        </span>
        <div class="h-1 flex-1 overflow-hidden rounded-pill bg-surface">
          <div
            class="h-full rounded-pill bg-[var(--type-accent)] transition-all duration-500"
            style={"width: #{if @winning_value && winning_letter(@winning_value) == String.at(@axis, 0), do: "70%", else: "30%"}"}
          />
        </div>
        <span class={[
          "flex size-9 items-center justify-center rounded-md font-display text-base font-bold transition-colors",
          @winning_value && winning_letter(@winning_value) == String.at(@axis, 2) &&
            "bg-[var(--type-accent)] text-canvas",
          @winning_value && winning_letter(@winning_value) != String.at(@axis, 2) &&
            "bg-surface text-text-faint"
        ]}>
          {String.at(@axis, 2)}
        </span>
      </div>
      <p class="mt-3 text-small font-bold text-text">
        {winning_pole_label(@winning_value, @left_pole, @right_pole)}
      </p>
    </div>
    """
  end

  defp winning_letter(value) when is_binary(value), do: Map.get(@trait_to_letter, value)
  defp winning_letter(_), do: nil

  defp winning_pole_label(nil, left, _right), do: left

  defp winning_pole_label(value, left, right) do
    case Map.get(@trait_to_letter, value) do
      l when l in ["E", "S", "T", "J"] -> left
      _ -> right
    end
  end

  # ---------------------------------------------------------------------------
  # 3. traits_list
  # ---------------------------------------------------------------------------

  @doc """
  Renders MBTI traits as accent-tinted pills.
  """
  attr :id, :string, default: "traits-list"
  attr :traits, :list, required: true

  def traits_list(assigns) do
    ~H"""
    <ul id={@id} class="flex flex-wrap gap-2">
      <li
        :for={trait <- @traits}
        class="rounded-pill border border-[var(--type-accent)]/30 bg-[var(--type-accent)]/10 px-4 py-2 text-small font-medium text-text transition-transform hover:scale-105"
      >
        {trait}
      </li>
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # 4. careers_list
  # ---------------------------------------------------------------------------

  @doc """
  Renders suggested careers as neutral pills.
  """
  attr :id, :string, default: "careers-list"
  attr :careers, :list, required: true

  def careers_list(assigns) do
    ~H"""
    <ul id={@id} class="flex flex-wrap gap-2">
      <li
        :for={career <- @careers}
        class="rounded-pill border border-border bg-surface-2 px-4 py-2 text-small font-medium text-text transition-colors hover:border-border-strong hover:bg-surface-3"
      >
        {career}
      </li>
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # 5. famous_people
  # ---------------------------------------------------------------------------

  @doc """
  Renders famous people of the type as a responsive chip grid.
  """
  attr :id, :string, default: "famous-people"
  attr :people, :list, required: true

  def famous_people(assigns) do
    ~H"""
    <ul id={@id} class="grid grid-cols-1 gap-3 sm:grid-cols-2">
      <li
        :for={person <- @people}
        class="group flex items-center gap-3 rounded-lg border border-border bg-surface-2 px-4 py-3 transition-all duration-200 hover:-translate-y-0.5 hover:border-border-strong hover:shadow-default"
      >
        <span
          class="flex size-9 shrink-0 items-center justify-center rounded-pill bg-[var(--type-accent)]/15 font-display text-base font-bold text-[var(--type-accent)]"
          aria-hidden="true"
        >
          {String.at(person, 0)}
        </span>
        <span class="text-small font-medium text-text">{person}</span>
      </li>
    </ul>
    """
  end

  # ---------------------------------------------------------------------------
  # 6. ai_reason
  # ---------------------------------------------------------------------------

  @doc """
  Renders the AI-generated reasoning paragraph in a subtle accent-tinted card.
  """
  attr :id, :string, default: "ai-reason"
  attr :reason, :string, required: true

  def ai_reason(assigns) do
    ~H"""
    <div id={@id} class="rounded-xl border border-border bg-surface-2 p-6">
      <div class="mb-3 flex items-center gap-2 text-text-faint">
        <.icon name="hero-sparkles" class="size-4 text-[var(--type-accent)]" />
        <span class="text-small font-bold uppercase tracking-[0.2em]">AI Analysis</span>
      </div>
      <p class="text-body-l leading-relaxed text-text-muted">{@reason}</p>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # 7. share_bar
  # ---------------------------------------------------------------------------

  @doc """
  Renders the share-link bar with select + copy affordances. Emits
  `select_share_url` and `copy_share_url` phx-click events that the host
  LiveView translates into `select_input` / `copy_url` push_event calls
  handled by the `.ShareHandler` colocated hook.
  """
  attr :id, :string, default: "share-bar"
  attr :share_url, :string, required: true

  def share_bar(assigns) do
    ~H"""
    <div id={@id} class="flex items-center gap-2 rounded-pill border border-border bg-surface-2 p-2">
      <input
        type="text"
        value={@share_url}
        readonly
        id="share-url"
        phx-click="select_share_url"
        class="flex-1 bg-transparent px-4 py-2 text-small text-text-muted focus:outline-none cursor-pointer"
        aria-label="Share URL"
      />
      <button
        type="button"
        phx-click="copy_share_url"
        class="inline-flex items-center gap-1.5 rounded-pill bg-text px-4 py-2 text-small font-bold text-canvas transition-opacity hover:opacity-90"
        aria-label="Copy share link"
      >
        <.icon name="hero-clipboard-document" class="size-4" /> Copy
      </button>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # 8. result_empty
  # ---------------------------------------------------------------------------

  @doc """
  Renders the pre-analysis hero: headline, supporting copy, and a slot for
  the search input. Used as the landing state of the home page.
  """
  attr :id, :string, default: "result-empty"
  slot :inner_block, required: true

  def result_empty(assigns) do
    ~H"""
    <section id={@id} class="py-20 md:py-32 text-center">
      <h1 class="font-display text-hero font-bold leading-[1.05] tracking-tight text-text">
        Discover Your <span class="text-[var(--type-accent)]">MBTI</span>
      </h1>
      <p class="mx-auto mt-6 max-w-xl text-body-l text-text-muted">
        Analyze your Bluesky posts and uncover your personality type through AI.
      </p>
      <div class="mt-10 flex justify-center">
        {render_slot(@inner_block)}
      </div>
    </section>
    """
  end

  # ---------------------------------------------------------------------------
  # 9. result_loading
  # ---------------------------------------------------------------------------

  @doc """
  Renders the analysis-in-progress state.
  """
  attr :id, :string, default: "result-loading"

  def result_loading(assigns) do
    ~H"""
    <div id={@id} class="flex flex-col items-center gap-6 py-20 md:py-32 text-center">
      <div class="relative">
        <div class="size-16 animate-ping rounded-full bg-text-faint/20" />
        <div class="absolute inset-0 flex size-16 items-center justify-center">
          <.icon name="hero-sparkles" class="size-7 text-text-muted motion-safe:animate-spin" />
        </div>
      </div>
      <div>
        <p class="font-display text-h3 font-bold text-text">Analyzing posts…</p>
        <p class="mt-2 text-small text-text-faint">Reading your Bluesky to find your type.</p>
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # 10. result_error
  # ---------------------------------------------------------------------------

  @doc """
  Renders the analysis-failure state. Accepts a human-readable message.
  """
  attr :id, :string, default: "result-error"
  attr :message, :string, default: "Something went wrong while analyzing your posts."

  def result_error(assigns) do
    ~H"""
    <div
      id={@id}
      class="flex flex-col items-center gap-4 rounded-xl border border-red-500/40 bg-red-500/10 p-8 text-center"
    >
      <.icon name="hero-exclamation-circle" class="size-8 text-red-400" />
      <p class="text-body-l font-medium text-red-300">{@message}</p>
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # 11. search_input
  # ---------------------------------------------------------------------------

  @doc """
  Renders the Bluesky handle search form. Submits a top-level `handle`
  param matching the `handle_event("analyse", %{"handle" => handle})` shape.
  """
  attr :id, :string, default: "handle-search-form"
  attr :submit_event, :string, default: "analyse"
  attr :placeholder, :string, default: "your-handle.bsky.social"

  def search_input(assigns) do
    ~H"""
    <form
      id={@id}
      phx-submit={@submit_event}
      class="relative flex w-full max-w-xl items-center rounded-pill border border-border-strong bg-surface-2 shadow-prominent transition-colors focus-within:border-text-faint"
    >
      <.icon
        name="hero-at-symbol"
        class="pointer-events-none absolute left-5 size-5 text-text-faint"
      />
      <input
        type="text"
        name="handle"
        placeholder={@placeholder}
        autocomplete="off"
        class="flex-1 bg-transparent py-4 pl-12 pr-28 text-base text-text placeholder:text-text-faint focus:outline-none"
        aria-label="Bluesky handle"
      />
      <button
        type="submit"
        class="absolute right-2 inline-flex items-center gap-1.5 rounded-pill bg-text px-5 py-2.5 text-small font-bold tracking-wide text-canvas transition-opacity hover:opacity-90"
      >
        <.icon name="hero-sparkles" class="size-4" /> Analyze
      </button>
    </form>
    """
  end
end
