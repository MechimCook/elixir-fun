defmodule Markdown do
  @strong_tag ~r/__[^_]{1,}__/
  @em_tag ~r/_(?<!__)[^_]{1,}_(?!_)/

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    replace_md_with_tag(markdown)
    |> String.split("\n")
    |> Stream.map(&process(&1))
    |> Enum.join()
    |> patch()
  end

  defp replace_md_with_tag(w) do
    String.replace(w, @strong_tag, "<strong>\\g{0}</strong>")
    |> String.replace(@em_tag, "<em>\\g{0}</em>")
    |> String.replace("_", "")
  end

  defp process("#" <> t), do: parse_header_md_level("##{t}") |> enclose_with_header_tag()
  defp process("*" <> t), do: parse_list_md_level("*#{t}")
  defp process(t), do: "<p>#{t}</p>"

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {byte_size("#{h}"), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l), do: "<li>#{String.trim_leading(l, "* ")}</li>"

  defp enclose_with_header_tag({hl, htl}), do: "<h#{hl}>#{htl}</h#{hl}>"

  defp patch(l) do
    String.replace(l, "<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
