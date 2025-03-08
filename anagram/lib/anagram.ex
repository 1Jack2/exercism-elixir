defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Stream.filter(&(String.downcase(base) != String.downcase(&1)))
    |> Enum.filter(&(count_chars(base) == count_chars(&1)))
  end

  defp count_chars(string) do
    string
    |> String.downcase()
    # Correctly handles Unicode characters
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end
end
