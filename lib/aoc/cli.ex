defmodule AOC.CLI do
  def main(argv) do
    {opts, args, _} =
      OptionParser.parse(argv,
        strict: [day: :integer, part: :integer, help: :boolean],
        aliases: [d: :day, p: :part, h: :help]
      )

    if opts[:help] do
       IO.puts(:stderr, usage())
       System.halt(0)
    end

    day = opts[:day] || error("day is required")
    part = opts[:part] || 0
    filename = case args do
      [name | _] -> name
      [] -> error("input file is required")
    end

    solver = Module.concat([:"Day#{day}"])
    unless Code.ensure_loaded?(solver) do
      error("Day #{day} not implemented")
    end

    input = File.read!(filename)
    case part do
      1 ->
        solver.solve_1(input) |> IO.inspect(label: "Part 1")
      2 ->
        solver.solve_2(input) |> IO.inspect(label: "Part 2")
      _ ->
        solver.solve_1(input) |> IO.inspect(label: "Part 1")
        solver.solve_2(input) |> IO.inspect(label: "Part 2")
    end
  end

  defp usage do
    """
    usage: aoc [options] <input-file>
    options:
      -d, --day N       day to run
      -p, --part N      part to solve
      -h, --help        show this help
    """
  end

  defp error(msg, status \\ 1) do
    IO.puts(:stderr, msg)
    IO.puts(:stderr, usage())
    System.halt(status)
  end
end
