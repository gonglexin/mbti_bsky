defmodule MbtiBskyWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use MbtiBskyWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="flex flex-col min-h-screen bg-canvas text-text">
      <header class="px-4 sm:px-6 lg:px-8">
        <div class="mx-auto flex max-w-5xl items-center justify-between border-b border-border py-4">
          <div class="flex items-center gap-2">
            <a
              href="https://bsky.app/profile/mbti.blue"
              class="rounded-pill bg-surface-2 px-4 py-2 text-small font-bold tracking-wide text-text transition-colors hover:bg-surface-3"
            >
              MBTI.BLUE
            </a>
            <span class="hidden text-small text-text-faint sm:inline">MBTI Test for Bluesky</span>
          </div>
          <.theme_toggle />
        </div>
      </header>

      <main class="w-full max-w-full grow overflow-x-hidden px-4 py-20 sm:px-6 lg:px-8">
        <div class="mx-auto max-w-5xl space-y-4">
          {render_slot(@inner_block)}
        </div>
      </main>

      <footer class="border-t border-border px-4 py-6 text-small text-text-muted">
        <div class="mx-auto flex max-w-5xl items-center justify-center gap-1">
          <span>&copy;2026</span>
          <span>·</span>
          <a
            href="https://bsky.app/profile/gonglexin.com"
            class="transition-colors hover:text-text"
          >
            Created by <span class="underline underline-offset-4">@gonglexin.com</span>
          </a>
        </div>
      </footer>

      <.flash_group flash={@flash} />
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Hang in there while we get back on track")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="relative flex flex-row items-center rounded-pill border border-border bg-surface-2">
      <div class="pointer-events-none absolute left-0 h-full w-1/3 rounded-pill bg-surface-3 transition-[left] [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3" />

      <button
        class="relative z-10 flex w-1/3 cursor-pointer justify-center p-2 opacity-60 hover:opacity-100"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        aria-label={gettext("System theme")}
      >
        <.icon name="hero-computer-desktop-micro" class="size-4" />
      </button>

      <button
        class="relative z-10 flex w-1/3 cursor-pointer justify-center p-2 opacity-60 hover:opacity-100"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
        aria-label={gettext("Light theme")}
      >
        <.icon name="hero-sun-micro" class="size-4" />
      </button>

      <button
        class="relative z-10 flex w-1/3 cursor-pointer justify-center p-2 opacity-60 hover:opacity-100"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
        aria-label={gettext("Dark theme")}
      >
        <.icon name="hero-moon-micro" class="size-4" />
      </button>
    </div>
    """
  end
end
