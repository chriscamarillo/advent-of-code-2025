defmodule Day5 do
  @behaviour AOC.Solver

  def solve_1(input) do
    {ingredients, ranges} = input |> parse_input
    Enum.count(ingredients, &is_fresh(&1, ranges))
  end

  def solve_2(input) do
    {_, ranges} = input |> parse_input

    ranges
    |> Enum.sort(fn {l_start, _}, {r_start, _} -> l_start < r_start end)
    |> Enum.reduce([], fn right, acc ->
      case acc do
        [] ->
          [right]
        [left | rest] ->
          {l_start, l_stop} = left
          {r_start, r_stop} = right

          if l_stop >= r_start do
            [{l_start, max(l_stop, r_stop)} | rest]
          else
            [right | acc]
          end
      end
    end)
    |> Enum.reverse
    |> Enum.map(fn {start, stop} -> stop - start + 1 end)
    |> Enum.sum

  end

  defp parse_input(input) do
    [ranges, ingredients] = input |> String.split("\n\n")

    ingredients = ingredients
    |> String.split
    |> Enum.map(&String.to_integer/1)

    ranges = ranges
    |> String.split
    |> Enum.map(&(String.split(&1, "-")))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)

    {ingredients, ranges}
  end

  defp is_fresh(ingredient, ranges) do
    ranges |> Stream.filter(fn {start, stop} -> ingredient >= start and ingredient <= stop end) |> Enum.any?
  end
end
