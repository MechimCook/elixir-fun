defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    uppers = ?A..?Z
    downers = ?a..?z

    text
    |> String.to_charlist()
    |> Enum.reduce('', fn char, acc ->
      shifted =
        cond do
          Enum.member?(uppers, char) ->
            if char + shift > 90 do
              char + shift - 90 + 64
            else
              char + shift
            end

          Enum.member?(downers, char) ->
            if char + shift > 122 do
              char + shift - 122 + 96
            else
              char + shift
            end

          true ->
            char
        end

      acc ++ [shifted]
    end)
    |> List.to_string()
  end
end
