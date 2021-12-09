defmodule SurfacePlaygroundWeb.Counter do
  use Phoenix.LiveView

  def mount(_, _, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H"""
    <div class = "container">
      <h1 class = "title">Counter</h1>
      <label id="counter"><%= @count %></label>
      <button phx-click="count" id="count">Add 1</button>
    </div>
    """
  end

  def handle_event("count", _value, socket) do
    {:noreply, update(socket, :count, fn count -> count + 1 end)}
  end
end
