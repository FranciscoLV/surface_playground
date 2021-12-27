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
      <Slider type="range" name="duration-slider" opts={min: "0", max: "100", step: "1"}/>
    </Field>
    <Field name="reset">
      <Button to="#" label="reset"/>
    </Field>

    """
  end

  # We must have a gauge for the elapsed time.
  # We must have a label that shows the elapsed time as a number.
  # We must have a slider that can change the duration of the timer.
  # Changing the slider should immediately cause the elapsed time gauge to change.
  # When the elapsed time is greater than or equal to the duration (when the gauge is full), the timer should stop. If we then move the slider to increase the duration, the timer should resume.
  # Finally, we should have a reset button that resets the elapsed time to zero.
end
