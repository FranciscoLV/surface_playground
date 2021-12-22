defmodule SurfacePlayground.ValidateFlight do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :flight_type, :string
    field :departure, :date
    field :return, :date
  end

  def flight_types, do: ["one-way flight", "round trip"]
  def required_fields, do: [:flight_type, :departure]
  def other_fields, do: [:return]

  def changeset(flight, %{"flight_type" => flight_type} = params) do
    case flight_type do
      "one-way flight" -> validate_one_way_flight(flight, params)
      "round trip" -> validate_round_trip(flight, params)
    end
  end

  def validate_one_way_flight(flight, params \\ %{"flight_type" => "one-way flight"}) do
    flight
    |> cast(params, required_fields())
    |> validate_required(required_fields())
    |> validate_inclusion(:flight_type, ["one-way flight"])
  end

  def validate_round_trip(flight, params \\ %{"flight_type" => "round trip"}) do
    flight
    |> cast(params, required_fields())
    |> validate_required(required_fields() ++ other_fields())
    |> validate_inclusion(:flight_type, ["round trip"])
  end

  def validate_dates(changeset) do
    departure = get_field(changeset, :departure)
    return = get_field(changeset, :return)

    if departure && return && Date.compare(departure, return) != :lt do
      bad_date_error(changeset)
    else
      changeset
    end
  end

  def bad_date_error(changeset) do
    if Enum.empty?(changeset.errors) do
      add_error(changeset, :bad_date, "Return flight must be later than departure flight")
    else
      changeset
    end
  end
end
