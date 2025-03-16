defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    do_score({x, y})
  end

  defp do_score({x, y}) when x * x + y * y <= 1 do
    10
  end

  defp do_score({x, y}) when x * x + y * y > 1 and x * x + y * y <= 25 do
    5
  end

  defp do_score({x, y}) when x * x + y * y > 25 and x * x + y * y <= 100 do
    1
  end

  defp do_score({_x, _y}) do
    0
  end
end
