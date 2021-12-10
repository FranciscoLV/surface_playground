defmodule SurfacePlayground.Temperature do
  def from_c_to_f(temp) do
    temp * 9 / 5 + 32
  end

  def from_f_to_c(temp) do
    (temp - 32) * 5 / 9
  end
end
