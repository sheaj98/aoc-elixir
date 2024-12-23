defmodule Advent.Year2024.Day02 do
  def part1(args) do
    parse(args)
    |> Enum.count(fn levels ->
      safe?(levels)
    end)
  end

  def part2(args) do
    parse(args)
    |> Enum.count(fn levels ->
      safe_with_damp?(levels, [])
    end)
  end

  defp safe_with_damp?([level | levels], prefix) do
    safe?(Enum.reverse(prefix, levels)) or
      safe_with_damp?(levels, [level | prefix])
  end

  defp safe_with_damp?([], prefix) do
    safe?(prefix)
  end

  # If list starts the same, it's not safe
  defp safe?([a, a | _]), do: false

  # If first two elements are diff, get the sign
  defp safe?([a, b | _] = levels) do
    diff = a - b
    safe?(levels, div(diff, abs(diff)))
  end

  defp safe?(levels, sign) do
    Enum.chunk_every(levels, 2, 1)
    |> Enum.all?(fn chunks ->
      case chunks do
        [a, b] ->
          (sign * (a - b)) in 1..3

        [_] ->
          true
      end
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ")
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end
