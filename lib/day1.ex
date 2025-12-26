defmodule Day1 do
  @behaviour AOC.Day

  def solve_1(input) do
    String.split(input)
    |> Enum.map(fn
      <<"L"::utf8, amount::binary>> -> -String.to_integer(amount)
      <<"R"::utf8, amount::binary>> -> String.to_integer(amount)
    end)
    |> Enum.reduce({50, 0}, fn rot, {pos, clicks} ->
      cond do
        rem(pos + rot, 100) == 0 -> {Integer.mod(pos + rot, 100), clicks + 1}
        true -> {Integer.mod(pos + rot, 100), clicks}
      end
    end)
    |> elem(1)
  end

  def solve_2(input) do
    String.split(input)
    |> Enum.map(fn
      <<"L"::utf8, amount::binary>> -> -String.to_integer(amount)
      <<"R"::utf8, amount::binary>> -> String.to_integer(amount)
    end)
    |> Enum.reduce({50, 0}, fn rot, {pos, clicks} ->
      cond do
        rem(pos + rem(rot, 100), 100) == 0 ->
          {Integer.mod(pos + rot, 100), clicks + 1 + abs(div(rot, 100))}

        rot > 0 and pos + rem(rot, 100) > 100 ->
          {Integer.mod(pos + rot, 100), clicks + 1 + abs(div(rot, 100))}

        rot < 0 and pos + rem(rot, 100) < 0 and pos > 0 ->
          {Integer.mod(pos + rot, 100), clicks + 1 + abs(div(rot, 100))}

        true ->
          {Integer.mod(pos + rot, 100), clicks + abs(div(rot, 100))}
      end
    end)
    |> elem(1)
  end
end
