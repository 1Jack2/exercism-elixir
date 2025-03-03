defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-" <>
      (1000..9999
       |> Enum.random()
       |> to_string())
  end

  def random_stardate() do
    1000 * :rand.uniform() + 41000
  end

  def format_stardate(stardate) do
    #  take a floating point number and return a string with the number rounded to a single decimal place.
    # CaptainsLog.format_stardate(41458.15721310934)
    # => "41458.2"
    :io_lib.format("~.1f", [stardate]) |> to_string()
  end
end
