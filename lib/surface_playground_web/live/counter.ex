defmodule SurfacePlaygroundWeb.Counter do
  use Surface.LiveView,
    layout: {SurfacePlaygroundWeb.LayoutView, "live.html"}

  alias Surface.Components.Form
  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Submit

  def mount(_, _, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~F"""
    <Form for={:counter} submit="count">
      <h1>Counter</h1>
      <Label text={@count} />
      <Submit label="Add 1"/>
    </Form>
    """
  end

  def handle_event("count", _value, socket) do
    {:noreply, update(socket, :count, fn count -> count + 1 end)}
  end
end
