defmodule SurfacePlaygroundWeb.Temperature do
  use Phoenix.LiveView

  def mount(_, _, socket) do
    {:ok, assign(socket, %{celsius: 0, farenheit: 0})}
  end

  def render(assigns) do
    ~H"""
    <div class = "container">
      <h1 class = "title">Temperature Converter</h1>
      <form phx-change="celsius-change" action="#" id="celsius">
        <label id="counter">Celsius</label>
        <input type="text" value={@celsius} />
      </form>
      <form phx-change="farenheit-change" action="#" id="farenheit">
        <label id="counter">Farenheit</label>
        <input type="text" value={@farenheit} />
      </form>
    </div>
    """
  end

  def handle_event("celsius-change", %{"celsius" => temp}, socket) do
    IO.inspect(temp, label: "temp")

    {:noreply, socket}
  end

  # def handle_event("temp-change", %{"farenheit" => temp}, socket) do

  #   {:noreply, socket}
  # end
end
