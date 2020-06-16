defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    if String.match?(raw, ~r/[A-z]/) do
      "0000000000"
    else
      Regex.replace(~r/(?![0-9])./, raw, "")
      |> validate()
    end
  end

  defp sizing(raw), do: String.length(raw) == 10

  defp validate(filtered) do
    cond do
      String.first(filtered) == "1" ->
        String.slice(filtered, 1..-1)
        |> validate()

      String.at(filtered, 0) == "0" ->
        "0000000000"

      String.match?(String.at(filtered, 3), ~r/[0-1]/) ->
        "0000000000"

      sizing(filtered) ->
        filtered

      true ->
        "0000000000"
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    number(raw)
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    [area, middle, last] =
      number(raw)
      |> String.split(~r{[0-9][0-9][0-9]}, include_captures: true, parts: 3, trim: true)

    "(#{area}) #{middle}-#{last}"
  end
end
