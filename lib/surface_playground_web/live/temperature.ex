defmodule SurfacePlaygroundWeb.Temperature do
  use Phoenix.LiveView

  alias SurfacePlayground.Temperature

  def mount(_, _, socket) do
    {:ok, assign(socket, %{celsius: 0, farenheit: 32})}
  end

  def render(assigns) do
    ~H"""
    <div class = "container">
      <h1 class = "title">Temperature Converter</h1>
      <form phx-change="celsius-change" action="#" id="celsius">
        <label id="celsius">Celsius</label>
        <input type="number" name="celsius" value={@celsius} />
      </form>
      <form phx-change="farenheit-change" action="#" id="farenheit">
        <label id="farenheit">Farenheit</label>
        <input type="number" name="farenheit" value={@farenheit} />
      </form>
    </div>
    """
  end

  def handle_event("celsius-change", %{"celsius" => temp}, socket) do
    case Float.parse(temp) do
      {celsius, ""} ->
        farenheit = Temperature.from_c_to_f(celsius)
        {:noreply, assign(socket, celsius: celsius, farenheit: farenheit)}

      _error ->
        socket = put_flash(socket, :error, "Value must be an integer")
        {:noreply, socket}
    end
  end

  def handle_event("farenheit-change", %{"farenheit" => temp}, socket) do
    case Float.parse(temp) do
      {farenheit, ""} ->
        celsius = Temperature.from_f_to_c(farenheit)
        {:noreply, assign(socket, celsius: celsius, farenheit: farenheit)}

      _error ->
        socket = put_flash(socket, :error, "Value must be an integer")
        {:noreply, socket}
    end
  end
end
