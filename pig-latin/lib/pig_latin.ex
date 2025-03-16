defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      String.starts_with?(word, ["a", "e", "i", "o", "u", "xr", "yt"]) ->
        word <> "ay"

      String.match?(word, ~r/^([^aeiou]*qu)(.*)/) ->
        [_, beginning, rest] = Regex.run(~r/^([^aeiou]*qu)(.*)/, word)
        rest <> beginning <> "ay"

      String.match?(word, ~r/^([^aeiou]+)(y.*)/) ->
        [_, beginning, rest] = Regex.run(~r/^([^aeiou]+)(y.*)/, word)
        rest <> beginning <> "ay"

      String.match?(word, ~r/^([^aeiou]+)(.*)/) ->
        [_, beginning, rest] = Regex.run(~r/^([^aeiou]+)(.*)/, word)
        rest <> beginning <> "ay"

      true ->
        word <> "ay"
    end
  end
end
