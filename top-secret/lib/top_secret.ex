defmodule TopSecret do
  def to_ast(string) do
    {:ok, quoted_form} = Code.string_to_quoted(string)
    quoted_form
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {:defp, _, [{:when, _, c} | _]} ->
        do_params(c, ast, acc)

      {:def, _, [{:when, _, c} | _]} ->
        do_params(c, ast, acc)

      {:defp, _, c} ->
        do_params(c, ast, acc)

      {:def, _, c} ->
        do_params(c, ast, acc)

      _ ->
        {ast, acc}
    end
  end

  defp do_params(params, ast, acc) do
    list = params |> hd |> elem(2)
    n = if list == nil, do: 0, else: list |> length()
    {ast, [params |> hd |> elem(0) |> to_string |> String.slice(0, n) | acc]}
  end

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
