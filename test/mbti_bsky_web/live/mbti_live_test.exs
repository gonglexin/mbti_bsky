defmodule MbtiBskyWeb.MbtiLiveTest do
  use MbtiBskyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "GET / renders the search hero", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#home-empty")
    assert has_element?(view, "#home-search")
  end
end
