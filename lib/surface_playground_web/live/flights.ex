defmodule SurfacePlaygroundWeb.Flights do
  use Surface.LiveView,
    layout: {SurfacePlaygroundWeb.LayoutView, "live.html"}

  alias SurfacePlayground.BookFlight
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.Select
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.ErrorTag
  alias Surface.Components.Form.Submit

  def mount(_, _, socket) do
    {:ok,
     assign(socket, %{
       changeset: BookFlight.new_booking(),
       flight_type: BookFlight.flight_types()
     })}
  end

  def render(assigns) do
    ~F"""
      <h1>Book Flight</h1>
      <Form for={@changeset} submit="book" change="validate" opts={id: "flight-booker"}>
        <Field name={:flight_type}>
          <Select options={@flight_type} opts={id: "flight_type"}/>
        </Field>
        <Field name={:departure}>
          <TextInput class={check_date_errors(@changeset, :departure)}/>
          <ErrorTag class="invalid date"/>
        </Field>
        <Field name={:return}>
          <TextInput class={check_date_errors(@changeset, :return)} opts={id: "return-date", disabled: one_way_flight?(@changeset)}/>
          <ErrorTag/>
        </Field>

        <Field name={:bad_date}>
          <ErrorTag class="invalid date"/>
        </Field>

        <Submit label="Book Flight" opts={id: "book-flight", disabled: !@changeset.valid?}/>
      </Form>
    """
  end

  def handle_event("validate", %{"flight" => params}, socket) do
    changeset = BookFlight.booking_change(socket.assigns.changeset, params)

    socket
    |> assign(:changeset, changeset)
    |> noreply()
  end

  def handle_event("book", %{"flight" => params}, socket) do
    {:ok, message} =
      socket.assigns.changeset
      |> BookFlight.booking_change(params)
      |> BookFlight.book_trip()

    socket
    |> put_flash(:info, message)
    |> noreply()
  end

  defp one_way_flight?(changeset) do
    BookFlight.one_way?(changeset.changes)
  end

  defp check_date_errors(changeset, field) do
    if changeset.errors[field] do
      "invalid date"
    end
  end

  defp noreply(socket), do: {:noreply, socket}
end

# Invalid dates should be highlighted in red.
# The submit button should be disabled whenever something is invalid.
# Upon submission, the user should get a confirmation message with the booking dates.
