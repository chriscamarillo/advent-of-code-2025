defmodule Day6 do
  @behaviour AOC.Solver

  def solve_1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.reverse()
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.map(fn [operator | operands] ->
      operands = operands |> Enum.map(&String.to_integer/1)

      operator =
        case operator do
          "+" -> &+/2
          "*" -> &*/2
        end

      operands |> Enum.reduce(operator)
    end)
    |> Enum.sum()
  end

  def solve_2(input) do
    chunks =
      input
      |> String.split("\n")
      |> Enum.map(&String.codepoints/1)
      |> Enum.zip_with(&Function.identity/1)
      |> Enum.reverse()
      |> Enum.chunk_while(
        [],
        fn row, acc ->
          acc = [row | acc]

          if List.last(row) in ["+", "*"] do
            {:cont, Enum.reverse(acc), []}
          else
            {:cont, acc}
          end
        end,
        fn
          [] -> {:cont, []}
          acc -> {:cont, Enum.reverse(acc)}
        end
      )

    chunks
    |> Enum.map(fn chunk ->
      op =
        case List.last(chunk) |> List.last() do
          "+" -> &+/2
          "*" -> &*/2
        end

      chunk
      # |> Enum.take_while(fn e -> List.last(e) not in ["+", "*"] end)
      |> Enum.map(fn digits ->
        digits |> Enum.filter(fn e -> e not in ["+", "*"] end) |> Enum.join() |> String.trim()
      end)
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(op)
    end)
    |> Enum.sum()
  end
end
