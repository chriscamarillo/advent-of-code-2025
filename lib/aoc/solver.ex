defmodule AOC.Solver do
  @type input() :: String.t()

  @callback solve_1(input()) :: any()
  @callback solve_2(input()) :: any()
end
