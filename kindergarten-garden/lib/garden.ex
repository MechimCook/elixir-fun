defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]
  @plant_names %{"V" => :violets, "R" => :radishes, "C" => :clover, "G" => :grass}

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names) do
    names = Enum.sort(student_names)
    rows = String.split(info_string, "\n")

    Enum.into(names, %{}, fn name -> {name, {}} end)
    |> from_rows(rows, names)
  end

  defp from_rows(window, [], _student_names), do: window

  defp from_rows(window, [row | tail], student_names) do
    String.split_at(row, 2)
    |> (&to_kids(window, &1, student_names)).()
    |> from_rows(tail, student_names)
  end

  defp to_kids(window, {kids_plants, ""}, [kid | _names]) do
    String.codepoints(kids_plants)
    |> Enum.reduce(window, fn plant, acc ->
      Map.update(
        acc,
        kid,
        {Map.get(@plant_names, plant)},
        &Tuple.append(&1, Map.get(@plant_names, plant))
      )
    end)
  end

  defp to_kids(window, {kids_plants, plants}, [kid | names]) do
    String.codepoints(kids_plants)
    |> Enum.reduce(window, fn plant, acc ->
      Map.update(
        acc,
        kid,
        {Map.get(@plant_names, plant)},
        &Tuple.append(&1, Map.get(@plant_names, plant))
      )
    end)
    |> to_kids(String.split_at(plants, 2), names)
  end
end
