# https://adventofcode.com/2015/day/4

input = "ckczppom"

defmodule Aoc.Day04 do
  def find_lowest_with_prefix(secret, prefix) do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(fn index ->
      hash =
        (secret <> Integer.to_string(index))
        |> :erlang.md5()
        |> Base.encode16()

      {index, hash}
    end)
    |> Enum.find(fn {_index, hash} ->
      String.starts_with?(hash, prefix)
    end)
  end
end

# Part 1
{index, hash} = Aoc.Day04.find_lowest_with_prefix(input, "00000")

IO.puts("Index: #{index}")
IO.puts("Hash:  #{hash}")

# Part 2 
{index, hash} = Aoc.Day04.find_lowest_with_prefix(input, "000000")

IO.puts("Index: #{index}")
IO.puts("Hash:  #{hash}")


