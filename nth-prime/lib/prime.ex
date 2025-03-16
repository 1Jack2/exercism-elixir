defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1 do
    raise "There is no zeroth prime."
  end

  def nth(count) do
    find_nth_prime(count, [2], 3)
  end

  defp find_nth_prime(count, primes = [head | _], _) when count == length(primes) do
    head
  end

  defp find_nth_prime(count, primes, current) do
    if Enum.all?(primes, fn prime -> rem(current, prime) != 0 end) do
      find_nth_prime(count, [current | primes], current + 2)
    else
      find_nth_prime(count, primes, current + 2)
    end
  end
end
