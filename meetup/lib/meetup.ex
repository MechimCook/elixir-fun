defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weeknums %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    case Date.new(year, month, 1) do
      {:ok, date} ->
        get_day(date, @weeknums[weekday])
        |> get_nth(date, schedule)

      {:error, error} ->
        error
    end
  end

  defp get_nth(first_day, date, :first), do: Date.add(date, first_day)
  defp get_nth(first_day, date, :second), do: Date.add(date, first_day + 7)
  defp get_nth(first_day, date, :third), do: Date.add(date, first_day + 14)
  defp get_nth(first_day, date, :fourth), do: Date.add(date, first_day + 21)
  defp get_nth(first_day, date, :fifth), do: Date.add(date, first_day + 28)

  defp get_nth(first_day, date, :last) do
    if first_day + 28 < Date.days_in_month(date) do
      get_nth(first_day, date, :fifth)
    else
      get_nth(first_day, date, :fourth)
    end
  end

  defp get_nth(first_day, date, :teenth) do
    if first_day + 7 >= 12 do
      get_nth(first_day, date, :second)
    else
      get_nth(first_day, date, :third)
    end
  end

  defp get_day(date, day) do
    current_day = Date.day_of_week(date)

    cond do
      current_day == day ->
        0

      current_day > day ->
        7 + day - current_day

      current_day < day ->
        day - current_day
    end
  end
end
