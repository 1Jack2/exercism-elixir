defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        digits
        |> to_decimal(input_base)
        |> from_decimal(output_base)
    end
  end

  defp to_decimal(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, acc ->
      (acc + digit * :math.pow(input_base, index)) |> round()
    end)
  end

  # Special case for 0
  defp from_decimal(0, _output_base), do: {:ok, [0]}

  defp from_decimal(decimal, output_base) do
    do_from_decimal(decimal, output_base, [])
  end

  defp do_from_decimal(0, _output_base, acc), do: {:ok, acc}

  defp do_from_decimal(decimal, output_base, acc) do
    remainder = rem(decimal, output_base)
    quotient = div(decimal, output_base)
    do_from_decimal(quotient, output_base, [remainder | acc])
  end
end
