defmodule SurfacePlaygroundWeb.Temperature do
  use Surface.LiveView,
    layout: {SurfacePlaygroundWeb.LayoutView, "live.html"}

  alias SurfacePlayground.Temperature
  alias Surface.Components.Form
  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput

  def mount(_, _, socket) do
    {:ok, assign(socket, %{celsius: 0, farenheit: 32})}
  end

  def render(assigns) do
    ~F"""
    <h1 class = "title">Temperature Converter</h1>
    <Form for={:celsiustemp} change="celsius-change">
      <Field name={:celsius}>
        <Label text="Celsius"/>
        <TextInput value={@celsius}/>
      </Field>
    </Form>
    <Form for={:farenheittemp} change="farenheit-change">
      <Field name={:farenheit}>
        <Label text="Farenheit"/>
        <TextInput value={@farenheit}/>
      </Field>
    </Form>
    """
  end

  def handle_event("celsius-change", %{"celsiustemp" => %{"celsius" => temp}}, socket) do
    case Float.parse(temp) do
      {celsius, ""} ->
        farenheit = Temperature.from_c_to_f(celsius)
        {:noreply, assign(socket, celsius: celsius, farenheit: farenheit)}

      _error ->
        socket = put_flash(socket, :error, "Value must be an integer")
        {:noreply, socket}
    end
  end

  def handle_event("farenheit-change", %{"farenheittemp" => %{"farenheit" => temp}}, socket) do
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
