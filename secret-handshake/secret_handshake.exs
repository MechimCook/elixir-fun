defmodule SecretHandshake do
  use Bitwise

  @shake_codes [0b00001, 0b00010, 0b00100, 0b01000, 0b10000]

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(@shake_codes, [], &command_map(&1 &&& code, &2))
  end

  defp command_map(0b00001, shake), do: shake ++ ["wink"]
  defp command_map(0b00010, shake), do: shake ++ ["double blink"]
  defp command_map(0b00100, shake), do: shake ++ ["close your eyes"]
  defp command_map(0b01000, shake), do: shake ++ ["jump"]
  defp command_map(0b10000, shake), do: Enum.reverse(shake)
  defp command_map(_, shake), do: shake
end
