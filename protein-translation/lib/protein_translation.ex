defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  @codons %{
    "AUG" => "Methionine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGA" => "STOP",
    "UAA" => "STOP",
    "UAG" => "STOP"
  }
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    results =
      Regex.scan(~r/.../, rna)
      |> List.flatten()
      |> Enum.reduce_while([], fn x, acc ->
        case Map.get(@codons, x) do
          nil ->
            {:halt, ["invalid RNA"]}

          "STOP" ->
            {:halt, acc}

          codon ->
            {:cont, [acc | [codon]]}
        end
      end)
      |> List.flatten()
      |> Enum.uniq()

    case results do
      ["invalid RNA"] ->
        {:error, "invalid RNA"}

      _ ->
        {:ok, results}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  AUG -> Methionine

  UGU -> Cysteine
  UGC -> Cysteine
  UGG -> Tryptophan
  UGA -> STOP

  UUA -> Leucine
  UUG -> Leucine
  UUU -> Phenylalanine
  UUC -> Phenylalanine

  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine

  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP

  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.get(@codons, codon) do
      nil ->
        {:error, "invalid codon"}

      protein ->
        {:ok, protein}
    end
  end
end
