defmodule Matrix do
  defstruct rows: []

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """

  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows =
      String.split(input, "\n")
      |> Enum.reduce([], fn x, acc ->
        List.insert_at(acc, -1, strings_to_ints(x))
      end)

    %Matrix{rows: rows}
  end

  defp strings_to_ints(lists) do
    String.split(lists, " ")
    |> Enum.reduce([], fn element, acc -> acc ++ [String.to_integer(element)] end)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    Map.get(matrix, :rows)
    |> inspect(charlists: :as_lists)
    |> String.replace("], [", "\n")
    |> String.replace(["]", ",", "["], "")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: Map.get(matrix, :rows)

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Map.get(matrix, :rows)
    |> Enum.at(index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    Map.get(matrix, :rows)
    |> Enum.reduce([], fn row, acc ->
      to_columns(row, acc)
    end)
  end

  def to_columns([], results) do
    results
  end

  def to_columns([element | remaining_row], []) do
    # first guide
    [[element]] ++ to_columns(remaining_row, [])
  end

  def to_columns([element | remaining_row], [current_row | other_rows]) do
    [current_row ++ [element] | to_columns(remaining_row, other_rows)]
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    columns(matrix)
    |> Enum.at(index)
  end
end
