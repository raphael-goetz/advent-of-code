# https://adventofcode.com/2015/day/3

defmodule Aoc.Day03 do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.to_charlist()

      {:error, _} ->
        IO.puts("Error occurred")
    end
  end

  def collect_coordinates(input) do
    input
    |> Enum.map_reduce({0, 0}, fn char, {x, y} ->
      new_pos =
        case char do
          ?^ -> {x, y + 1}
          ?> -> {x + 1, y}
          ?< -> {x - 1, y}
          ?v -> {x, y - 1}
          _ -> {x, y}
        end

      {new_pos, new_pos}
    end)
    |> then(fn {coords_tuple, _} ->
      [{0, 0} | coords_tuple]
    end)
  end

  def robo_santa(input) do
    instr_santa =
      input
      |> Enum.with_index()
      |> Enum.filter(fn {_, index} -> rem(index, 2) == 1 end)
      |> Enum.map(fn {char, _} -> char end)
      |> Aoc.Day03.collect_coordinates()

    instr_robo =
      input
      |> Enum.with_index()
      |> Enum.filter(fn {_, index} -> rem(index, 2) == 0 end)
      |> Enum.map(fn {char, _} -> char end)
      |> Aoc.Day03.collect_coordinates()

    instr_santa ++ instr_robo
  end
end

input = Aoc.Day03.read_file("./day03.txt")

# Part 1
input
|> Aoc.Day03.collect_coordinates()
|> Enum.frequencies()
|> Map.keys()
|> Enum.count()
|> IO.inspect()

# Part 2
input
|> Aoc.Day03.robo_santa()
|> Enum.frequencies()
|> Map.keys()
|> Enum.count()
|> IO.inspect()
