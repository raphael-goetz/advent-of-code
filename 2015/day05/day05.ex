# https://adventofcode.com/2015/day/5

defmodule Aoc.Day05 do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.split("\r\n")

      {:error, _} ->
        IO.puts("Error occurred")
    end
  end

  def vowels?(word) do
    collected_vowels =
      word
      |> String.to_charlist()
      |> Enum.reduce(0, fn
        ?a, acc -> acc + 1
        ?e, acc -> acc + 1
        ?i, acc -> acc + 1
        ?o, acc -> acc + 1
        ?u, acc -> acc + 1
        _, acc -> acc
      end)

    if collected_vowels < 3 do
      false
    else
      true
    end
  end

  defp forbidden?(word) do
    collected_forbidden =
      ["ab", "cd", "pq", "xy"]
      |> Enum.reduce(0, fn
        fbdn, acc ->
          if String.contains?(word, fbdn) do
            acc + 1
          else
            acc
          end
      end)

    if collected_forbidden > 0 do
      true
    else
      false
    end
  end

  defp has_double?(word) do
    word
    |> String.to_charlist()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [a, b] -> a == b end)
  end

  def is_nice_p1?(word) do
    vowels?(word) and not forbidden?(word) and has_double?(word)
  end

  # Cound't solve this by myself :(

  defp has_repeating_pair?(word) do
    len = byte_size(word)

    if len < 4 do
      false
    else
      0..(len - 2)
      |> Enum.reduce_while(%{}, fn i, seen ->
        pair = binary_part(word, i, 2)

        case Map.fetch(seen, pair) do
          {:ok, first_i} when i - first_i >= 2 ->
            {:halt, true}

          :error ->
            {:cont, Map.put(seen, pair, i)}

          {:ok, _first_i} ->
            {:cont, seen}
        end
      end)
      |> case do
        true -> true
        _ -> false
      end
    end
  end

  defp repeat?(word) do
    word
    |> String.to_charlist()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn [a, _, c] ->
      a == c
    end)
  end

  def is_nice_p2?(word) do
    has_repeating_pair?(word) and repeat?(word)
  end
end

input = Aoc.Day05.read_file("./day05.txt") |> IO.inspect()

# Part 1
input
|> Enum.map(fn x -> Aoc.Day05.is_nice_p1?(x) end)
|> Enum.filter(fn x -> x end)
|> Enum.count()
|> IO.inspect()

# Part 2
input
|> Enum.map(fn x -> Aoc.Day05.is_nice_p2?(x) end)
|> Enum.filter(fn x -> x end)
|> Enum.count()
|> IO.inspect()

