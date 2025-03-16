defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) == length(strand2) do
    do_hamming_distance(strand1, strand2, 0)
  end

  def hamming_distance(_, _) do
    {:error, "strands must be of equal length"}
  end

  defp do_hamming_distance([], [], res) do
    {:ok, res}
  end

  defp do_hamming_distance([h | t1], [h | t2], res) do
    do_hamming_distance(t1, t2, res)
  end

  defp do_hamming_distance([_ | t1], [_ | t2], res) do
    do_hamming_distance(t1, t2, res + 1)
  end
end
