defmodule Day2 do
  require Integer

  def solve_1(input) do
    String.trim(input)
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.flat_map(fn [start, stop] -> String.to_integer(start)..String.to_integer(stop) end)
    |> Stream.filter(fn n ->
      digits = Integer.digits(n)
      n_digits = length(digits)
      n_digits > 1 and Integer.is_even(n_digits) and is_repeated(digits, div(n_digits, 2))
    end)
    |> Enum.reduce(&+/2)
    |> IO.inspect
  end

  def solve_2(input) do
    String.trim(input)
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.flat_map(fn [start, stop] -> String.to_integer(start)..String.to_integer(stop) end)
    |> Stream.filter(&is_invalid/1)
    |> Enum.reduce(&+/2)
    |> IO.inspect
  end

  def is_invalid(n) do
    digits = Integer.digits(n)
    len = length(digits)
    len > 1 and 1..div(len, 2)
    |> Stream.filter(&(rem(len, &1) == 0))
    |> Enum.reduce(false, &(&2 or is_repeated(digits, &1)))
  end

  def is_repeated(digits, k) do
    len = length(digits)
    pattern = Enum.slice(digits, 0, k)
    repeat_list = List.duplicate(pattern, div(len, k)) |> List.flatten
    repeat_list == digits
  end
end

{_, argv, _} = OptionParser.parse(System.argv(), switches: [])
filename = hd(argv)
input = File.read!(filename)

Day2.solve_1(input)
Day2.solve_2(input)
