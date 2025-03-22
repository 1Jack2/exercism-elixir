defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    do_encode(String.codepoints(string), nil, 0, "")
  end

  defp do_encode([], prev_char, count, res) do
    append = if count > 1, do: "#{count}#{prev_char}", else: "#{prev_char}"
    res <> append
  end

  defp do_encode([cur_char | tail], prev_char, count, res) when cur_char == prev_char do
    do_encode(tail, prev_char, count + 1, res)
  end

  defp do_encode([cur_char | tail], prev_char, count, res) when cur_char != prev_char do
    if prev_char != nil do
      append = if count > 1, do: "#{count}#{prev_char}", else: "#{prev_char}"
      do_encode(tail, cur_char, 1, res <> append)
    else
      do_encode(tail, cur_char, 1, res)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    do_decode(String.codepoints(string), "", "")
  end

  defp do_decode([], _num_str, result) do
    result
  end

  defp do_decode([char | rest], num_str, result) do
    if char >= "0" and char <= "9" do
      do_decode(rest, num_str <> char, result)
    else
      count = if num_str == "", do: 1, else: String.to_integer(num_str)
      new_part = String.duplicate(char, count)
      do_decode(rest, "", result <> new_part)
    end
  end
end
