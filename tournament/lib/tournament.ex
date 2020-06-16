defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  # %{"name" => %{MP: 0, W: 0, D: 0, L: 0, P: 0}}
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    Enum.reduce(input, %{}, fn game, scores ->
      String.split(game, ";")
      |> score(scores)
    end)
    |> Enum.sort_by(&mapper(&1), &sorter/2)
    |> format()
  end

  @win_first %{MP: 1, W: 1, D: 0, L: 0, P: 3}
  @loss_first %{MP: 1, W: 0, D: 0, L: 1, P: 0}
  @draw_first %{MP: 1, W: 0, D: 1, L: 0, P: 1}

  defp score([home, away, "win"], scores),
    do:
      Map.update(scores, home, @win_first, &update_win(&1))
      |> Map.update(away, @loss_first, &update_loss(&1))

  defp score([home, away, "loss"], scores),
    do:
      Map.update(scores, away, @win_first, &update_win(&1))
      |> Map.update(home, @loss_first, &update_loss(&1))

  defp score([home, away, "draw"], scores),
    do:
      Map.update(scores, home, @draw_first, &update_draw(&1))
      |> Map.update(away, @draw_first, &update_draw(&1))

  defp score(_, scores), do: scores

  defp update_win(team_scores) do
    Map.update(team_scores, :MP, 1, &(&1 + 1))
    |> Map.update(:W, 1, &(&1 + 1))
    |> Map.update(:P, 3, &(&1 + 3))
  end

  defp update_loss(team_scores) do
    Map.update(team_scores, :MP, 1, &(&1 + 1))
    |> Map.update(:L, 1, &(&1 + 1))
  end

  defp update_draw(team_scores) do
    Map.update(team_scores, :MP, 1, &(&1 + 1))
    |> Map.update(:D, 1, &(&1 + 1))
    |> Map.update(:P, 1, &(&1 + 1))
  end

  # sorting
  # sort by matches played, points, then name
  defp mapper({name, %{P: p, MP: mp}}), do: [mp, p, name]
  # if points and matches are equal sort name by ascending
  defp sorter([mp, p, name1], [mp, p, name2]), do: name1 <= name2
  # if points and matches are equal sort by descending
  defp sorter(first, second), do: first >= second

  defp format(scores) do
    Enum.reduce(
      scores,
      "Team                           | MP |  W |  D |  L |  P\n",
      fn {name, %{D: d, L: l, MP: mp, P: p, W: w}}, acc ->
        "#{acc}#{name}#{format_spaces(name)}|  #{mp} |  #{w} |  #{d} |  #{l} |  #{p}\n"
      end
    )
    |> String.trim()
  end

  defp format_spaces(name) do
    String.duplicate(" ", 31 - String.length(name))
  end
end
