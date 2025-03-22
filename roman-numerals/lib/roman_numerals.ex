defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    roman_map = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]

    do_numeral(number, roman_map, "")
  end

  defp do_numeral(0, _roman_map, result) do
    result
  end

  defp do_numeral(number, [{value, roman} | rest_map], result) do
    if number >= value do
      do_numeral(number - value, [{value, roman} | rest_map], result <> roman)
    else
      do_numeral(number, rest_map, result)
    end
  end

  defp do_numeral(_number, [], result) do
    result
  end
end
