defmodule SurfacePlayground.BookFlight do
  alias SurfacePlayground.ValidateFlight

  def flight_types, do: ValidateFlight.flight_types()

  def new_booking do
    today = Date.utc_today()
    data = %ValidateFlight{departure: today, return: today}

    ValidateFlight.validate_one_way_flight(data)
  end

  def booking_change(changeset, params) do
    changeset.data
    |> ValidateFlight.changeset(params)
    |> Map.put(:action, :insert)
  end

  def one_way?(%{flight_type: "one-way flight"}), do: true
  def one_way?(%{flight_type: "round trip"}), do: false
  def one_way?(_), do: true

  def book_trip(changeset) do
    flight = Ecto.Changeset.apply_changes(changeset)
    {:ok, get_message(flight)}
  end

  defp get_message(flight) do
    case flight.flight_type do
      "one_way flight" ->
        "You have booked a one-way flight on #{flight.departure}"

      "round trip" ->
        "You have booked a round trip departing on #{flight.departure} and returning on #{flight.return}"
    end
  end
end
