# https://adventofcode.com/2015/day/6
# Somehow this took me way to long. I did to much copy => in this case a mutable object would have been lovely :() 

defmodule Aoc.Day06 do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} ->
        body
        |> String.split("\r\n")

      {:error, _} ->
        IO.puts("Error occurred")
    end
  end

  def create_bool_field() do
    0..999
    |> Enum.map(fn _ ->
      0..999
      |> Enum.map(fn _ ->
        false
      end)
    end)
  end

  def create_int_field() do
    0..999
    |> Enum.map(fn _ ->
      0..999
      |> Enum.map(fn _ ->
        0
      end)
    end)
  end

  def extract_statements(line) do
    coords =
      line
      |> String.replace(["toggle", "turn", "off", "on", "through"], "")
      |> String.trim()
      |> String.replace("  ", ",")
      |> String.split(",")
      |> Enum.map(fn x -> String.to_integer(x) end)

    cond do
      String.starts_with?(line, "toggle") -> {:toggle, coords}
      String.starts_with?(line, "turn on") -> {:on, coords}
      String.starts_with?(line, "turn off") -> {:off, coords}
    end
  end

  def count_lights(input) do
    field =
      Aoc.Day06.create_bool_field()

    input
    |> Enum.map(fn line -> Aoc.Day06.extract_statements(line) end)
    |> Enum.with_index()
    |> Enum.reduce(field, fn {statement, index}, acc ->
      IO.inspect(index)

      case statement do
        {:toggle, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    !val
                  else
                    val
                  end
                end)
              else
                row
              end
            end)

        {:on, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    true
                  else
                    val
                  end
                end)
              else
                row
              end
            end)

        {:off, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    false
                  else
                    val
                  end
                end)
              else
                row
              end
            end)
      end
    end)
  end

  def count_light_level(input) do
    field =
      Aoc.Day06.create_int_field()

    input
    |> Enum.map(fn line -> Aoc.Day06.extract_statements(line) end)
    |> Enum.with_index()
    |> Enum.reduce(field, fn {statement, index}, acc ->
      IO.inspect(index)

      case statement do
        {:toggle, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    val + 2
                  else
                    val
                  end
                end)
              else
                row
              end
            end)

        {:on, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    val + 1
                  else
                    val
                  end
                end)
              else
                row
              end
            end)

        {:off, coords} ->
          [from_x, from_y, to_x, to_y] = coords

          new_grid =
            acc
            |> Enum.with_index()
            |> Enum.map(fn {row, x} ->
              if x in from_x..to_x do
                row
                |> Enum.with_index()
                |> Enum.map(fn {val, y} ->
                  if y in from_y..to_y do
                    if val == 1 or val == 0 do
                      0
                    else
                      val - 1
                    end
                  else
                    val
                  end
                end)
              else
                row
              end
            end)
      end
    end)
  end
end

input =
  Aoc.Day06.read_file("./day06.txt")
  |> Enum.filter(fn line -> line != "" end)

# Part 1
# result =
#  input
# |> Aoc.Day06.count_lights()
# |> Enum.reduce(0, fn row, acc ->
#   acc +
#     Enum.reduce(row, 0, fn light, count ->
#       if light, do: count + 1, else: count
#     end)
# end)
# |> IO.inspect()

# Part 2
input |> Aoc.Day06.count_light_level() |> List.flatten() |> Enum.sum() |> IO.inspect()
