defmodule SurfacePlaygroundWeb.Components.Slider do
  @moduledoc """
  A sample component generated by `mix surface.init`.
  """
  use Surface.Component

  # import SurfacePlaygroundWeb.Gettext

  @doc "The field name"
  prop name, :any

  @doc "The type of the slider"
  prop type, :string

  @doc "The id of the slider"
  prop id, :string

  @doc "Extra options for slider"
  prop opts, :keyword, default: []

  def render(assigns) do
    ~F"""
    <input :hook="Slider" type={@type} name={@name} id={@id} :attrs={@opts} />
    """
  end
end
