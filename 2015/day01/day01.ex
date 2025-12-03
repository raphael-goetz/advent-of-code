# https://adventofcode.com/2015/day/1

defmodule Aoc.Day01 do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.to_charlist()

      {:error, reason} ->
        IO.puts("Error occurred")
    end
  end

  def calc(input) do
    Enum.reduce(input, 0, fn
      ?(, acc -> acc + 1
      ?), acc -> acc - 1
      _, acc -> acc
    end)
  end

  def first_negative_one_occurrence(input) do
    input
    |> Enum.with_index()
    # Start at 1 because the first floor gets de/incremented before the second index begins!
    |> Enum.reduce_while(1, fn {ch, idx}, acc ->
      new_acc =
        case ch do
          ?( -> acc + 1
          ?) -> acc - 1
          _ -> acc
        end

      IO.puts("Current Floor: #{new_acc} at #{idx} ")

      if new_acc == -1 do
        {:halt, {new_acc, idx}}
      else
        {:cont, new_acc}
      end
    end)
  end
end

input = Aoc.Day01.read_file("./day01.txt")

# Part 1
one = Aoc.Day01.calc(input)
IO.puts(one)

# Part 2
{new_acc, idx} = Aoc.Day01.first_negative_one_occurrence(input)
IO.puts(idx)
