defmodule SurfacePlaygroundWeb.Timer do
  use Surface.LiveView,
    layout: {SurfacePlaygroundWeb.LayoutView, "live.html"}

  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Field
  alias Surface.Components.Link.Button
  alias SurfacePlaygroundWeb.Components.Gauge
  alias SurfacePlaygroundWeb.Components.Slider

  data timer, :integer, default: 0
  data range, :integer, default: 5

  def render(assigns) do
    ~F"""
    <h1 class = "title">Timer</h1>
    <Field name="gauge">
      <Label>Elapsed Time:</Label>
      <Gauge/>
    </Field>
    <div>
      {@timer} s
    </div>
    <Field name="slider">
      <Label>Duration: </Label>
      <Slider/>
    </Field>
    <Field name="reset">
      <Button to="#" label="reset" id="reset" method={nil} opts={type: "button", phx_click: "reset"}/>
    </Field>

    """
  end

  @spec mount(any, any, map) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_, _, socket) do
    if connected?(socket), do: start_timer()

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    timer = socket.assigns.timer
    range = socket.assigns.range

    if timer < range do
      socket
      |> update(:timer, fn seconds -> seconds + 1 end)
      |> noreply()
    else
      noreply(socket)
    end
  end

  def handle_event("reset", _, socket) do
    socket
    |> assign(:timer, 0)
    |> noreply()
  end

  defp start_timer() do
    :timer.send_interval(1_000, :tick)
  end

  defp noreply(socket), do: {:noreply, socket}
  # We must have a gauge for the elapsed time.
  # We must have a slider that can change the duration of the timer.
  # Changing the slider should immediately cause the elapsed time gauge to change.
  # When the elapsed time is greater than or equal to the duration (when the gauge is full), the timer should stop. If we then move the slider to increase the duration, the timer should resume.
end
