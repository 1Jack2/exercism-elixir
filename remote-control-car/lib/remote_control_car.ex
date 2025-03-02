defmodule RemoteControlCar do
  # Please implement the struct with the specified fields
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    to_string(distance) <> " meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: percentage}) do
    if percentage > 0 do
      "Battery at " <> to_string(percentage) <> "%"
    else
      "Battery empty"
    end
  end

  def drive(%RemoteControlCar{battery_percentage: percentage} = car) do
    if percentage > 0 do
      %{
        car
        | distance_driven_in_meters: car.distance_driven_in_meters + 20,
          battery_percentage: car.battery_percentage - 1
      }
    else
      car
    end
  end
end
