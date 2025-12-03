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

  def is_nice?(word) do
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
      IO.puts("Not enogth vowels")
      false
    end

    last_char = -1 
    collected_double = false

    word
    |> String.to_charlist()
    |> Enum.each(fn x ->
      IO.inspect(x)
      IO.inspect(last_char)

      if last_char == x do
        IO.puts("Found Duplicate")
        collected_double = true
      end

      last_char = x
    end)

    if !collected_double do
      IO.puts("No doubles")
      false
    end

    detected_forbidden = false

    ["ab", "cd", "pq", "xy"]
    |> Enum.each(fn fbdn ->
      if String.contains?(word, fbdn) do
        detected_forbidden = true
      end
    end)

    if detected_forbidden do
      IO.puts("Detected Forbidden")
      false
    else
      IO.puts("Word is nice")
      true
    end
  end
end

input = Aoc.Day05.read_file("./day05.txt") |> IO.inspect()
"ugknbfddgicrmopn" |> Aoc.Day05.is_nice?() |> IO.inspect()
