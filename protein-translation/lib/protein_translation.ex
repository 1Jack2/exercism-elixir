defmodule ProteinTranslation do
  @codon_map %{
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    codons = for <<codon::binary-3 <- rna>>, do: codon

    {proteins, hit_stop} =
      Enum.reduce_while(codons, {[], false}, fn codon, {acc, hit_stop?} ->
        case of_codon(codon) do
          {:ok, "STOP"} -> {:halt, {acc, true}}
          {:ok, protein} -> {:cont, {[protein | acc], hit_stop?}}
          {:error, _} -> {:halt, {{:error, "invalid RNA"}, false}}
        end
      end)

    case proteins do
      {:error, _} ->
        {:error, "invalid RNA"}

      list when is_list(list) ->
        if hit_stop do
          {:ok, Enum.reverse(list)}
        else
          processed_length = length(codons) * 3

          if processed_length == byte_size(rna) do
            {:ok, Enum.reverse(list)}
          else
            {:error, "invalid RNA"}
          end
        end
    end
  end

  @doc """
  Given a codon, return the corresponding protein.
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case byte_size(codon) do
      3 ->
        case Map.get(@codon_map, codon) do
          nil -> {:error, "invalid codon"}
          amino -> {:ok, amino}
        end

      _ ->
        {:error, "invalid codon"}
    end
  end
end
