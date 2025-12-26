defmodule Day3 do
  @behaviour AOC.Solver

  def solve_1(input) do
    input
    |> parse_input
    |> Enum.map(&pick_battery(&1, 2))
    |> Enum.map(&joltage/1)
    |> Enum.reduce(&+/2)
  end

  def solve_2(input) do
    input
    |> parse_input
    |> Enum.map(&pick_battery(&1, 12))
    |> Enum.map(&joltage/1)
    |> Enum.reduce(&+/2)
  end

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split()
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    for <<d <- line>>, do: d - ?0
  end

  def pick_battery(bank, choices) do
    cond do
      choices >= length(bank) ->
        bank

      choices <= 0 ->
        []

      true ->
        {max_value, max_index} =
          bank
          |> Enum.take(length(bank) - choices + 1)
          |> Enum.with_index()
          |> Enum.max_by(fn {digit, _index} -> digit end)

        rest = Enum.drop(bank, max_index + 1)

        [max_value | pick_battery(rest, choices - 1)]
    end
  end

  def joltage(batteries) do
    batteries
    |> Enum.join("")
    |> String.to_integer()
  end
end
