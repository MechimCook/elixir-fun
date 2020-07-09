defmodule IsbnVerifier do
  defguard valid_size(isbn) when byte_size(isbn) == 13 or byte_size(isbn) == 10

  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """

  # (x1 * 10 + x2 * 9 + x3 * 8 + x4 * 7 + x5 * 6 + x6 * 5 + x7 * 4 + x8 * 3 + x9 * 2 + x10 * 1) mod 11 == 0
  @spec isbn?(String.t()) :: boolean

  def isbn?(isbn) when byte_size(isbn) == 10,
    do: if(String.match?(isbn, ~r/[^0-9X]/), do: false, else: proccess_string(isbn))

  def isbn?(isbn) when byte_size(isbn) == 13,
    do: String.replace(isbn, ~r/[^0-9X]/, "") |> isbn?()

  def isbn?(_isbn), do: false

  defp proccess_string(isbn),
    do: String.codepoints(isbn) |> Enum.map(&to_integer(&1)) |> Enum.with_index() |> do_math()

  defp to_integer("X"), do: 10
  defp to_integer(string), do: String.to_integer(string)

  defp do_math(isbn, sum \\ 0)

  defp do_math([], sum),
    do: rem(sum, 11) == 0

  defp do_math([{current, index} | isbn], sum),
    do: do_math(isbn, sum + current * (10 - index))
end
