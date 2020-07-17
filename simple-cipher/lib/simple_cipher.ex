defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  @alphabet 'abcdefghijklmnopqrstuvwxyz'

  def encode(plaintext, key) when byte_size(key) == 1, do: code(:encrypt, plaintext, key)
  def encode(plaintext, key), do: code(:encrypt, plaintext, key)

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) when byte_size(key) == 1, do: code(:decrypt, ciphertext, key)
  def decode(ciphertext, key), do: code(:decrypt, ciphertext, key)
  # only uses 1 key
  def code(method, ciphertext, key) when byte_size(key) == 1 do
    key =
      String.to_charlist(key)
      |> List.first()
      |> get_key()

    Enum.reduce(String.to_charlist(ciphertext), '', &proccess_value(method, &1, key, &2))
    |> List.to_string()
  end

  # generates keys equal to the size of the string
  def code(method, ciphertext, key) do
    keys =
      String.to_charlist(key)
      |> Enum.map(&get_key(&1))
      |> Stream.cycle()
      |> Enum.take(byte_size(ciphertext))

    crypt(method, '', String.to_charlist(ciphertext), keys)
    |> List.to_string()
  end

  defp crypt(method, encrypted, [text | []], [key | _keys]),
    do: proccess_value(method, text, key, encrypted)

  defp crypt(method, encrypted, [text | remaining], [key | keys]),
    do:
      proccess_value(method, text, key, encrypted)
      |> (&crypt(method, &1, remaining, keys)).()

  defp proccess_value(:encrypt, text, key, encrypted) do
    case Enum.find_index(@alphabet, &(&1 == text)) do
      nil -> List.insert_at(encrypted, -1, text)
      index -> Enum.at(key, index) |> (&List.insert_at(encrypted, -1, &1)).()
    end
  end

  defp proccess_value(:decrypt, text, key, encrypted) do
    case Enum.find_index(key, &(&1 == text)) do
      nil -> List.insert_at(encrypted, -1, text)
      index -> Enum.at(@alphabet, index) |> (&List.insert_at(encrypted, -1, &1)).()
    end
  end

  defp get_key(key),
    do: Enum.split(@alphabet, Enum.find_index(@alphabet, &(&1 == key))) |> combine_halfs()

  defp combine_halfs({first, second}), do: second ++ first
end
