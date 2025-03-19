defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&shift_char(&1, shift))
    |> List.to_string()
  end

  defp shift_char(char, shift) when char in ?A..?Z do
    rem(char - ?A + shift, 26) + ?A
  end

  defp shift_char(char, shift) when char in ?a..?z do
    rem(char - ?a + shift, 26) + ?a
  end

  defp shift_char(char, _shift), do: char
end
