# https://adventofcode.com/2015/day/2

defmodule Aoc.Day02 do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} ->
        body

      {:error, _} ->
        IO.puts("Error occurred")
    end
  end

  def extrect_measurements(input) do
    input
    |> String.split("\r\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("x", trim: true)
      |> Enum.map(fn x -> x |> String.to_integer() end)
    end)
  end

  def calculate_required_material(input) do
    input
    |> Enum.reduce(0, fn meas, acc ->
      [length, width, height] = meas
      a = length * width
      b = length * height
      c = width * height
      min = Enum.min([a, b, c])
      side = 2 * a + 2 * b + 2 * c + min
      acc + side
    end)
  end

  def calculate_required_ribbon(input) do
    input
    |> Enum.reduce(0, fn meas, acc ->
      [a, b, c] = Enum.sort(meas)
      cube = a * b * c
      side = a + a + b + b
      acc + side + cube
    end)
  end
end

input = Aoc.Day02.read_file("./day02.txt")

# Part 1
input
|> Aoc.Day02.extrect_measurements()
|> Aoc.Day02.calculate_required_material()
|> IO.inspect()

# Part 2
input
|> Aoc.Day02.extrect_measurements()
|> Aoc.Day02.calculate_required_ribbon()
|> IO.inspect()
