defmodule Day4 do
  @behaviour AOC.Solver

  def solve_1(input) do
    input |> solve
  end

  def solve_2(input) do
    input |> solve(true)
  end

  defp solve(input, allow_removal \\ false) do
    input
    |> parse_grid
    |> get_all_toilet_paper_locations
    |> access_rolls(allow_removal)
    |> MapSet.size()
  end

  defp access_rolls(locations, allow_removal) do
    rolls =
      locations
      |> Enum.filter(&(get_neighbor_count(&1, locations) < 4))
      |> MapSet.new()

    if MapSet.size(rolls) > 0 and allow_removal do
      locations = MapSet.difference(locations, rolls)
      MapSet.union(rolls, access_rolls(locations, allow_removal))
    else
      rolls
    end
  end

  defp parse_grid(input) do
    input
    |> String.split()
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_n} ->
      String.codepoints(row)
      |> Enum.with_index()
      |> Enum.map(fn {item, col_n} ->
        {item, row_n, col_n}
      end)
    end)
  end

  defp get_all_toilet_paper_locations(grid) do
    grid
    |> Stream.filter(fn {item, _, _} -> item == "@" end)
    |> Enum.map(fn {_, row, col} -> {row, col} end)
    |> MapSet.new()
  end

  defp get_neighbor_count({row, col}, toilet_paper_locations) do
    [
      {row, col - 1},
      {row, col + 1},
      {row - 1, col},
      {row - 1, col - 1},
      {row - 1, col + 1},
      {row + 1, col},
      {row + 1, col - 1},
      {row + 1, col + 1}
    ]
    |> MapSet.new()
    |> MapSet.intersection(toilet_paper_locations)
    |> MapSet.size()
  end
end
