defmodule Advent.Year2024.Day01 do
  def part1(args) do
    args
    |> parse
    |> then(fn {left, right} -> Enum.zip(Enum.sort(left), Enum.sort(right)) end)
    |> Enum.reduce(0, fn {l, r}, acc -> acc + abs(l - r) end)
  end

  def part2(args) do
    {left, right} = parse(args)

    right_freq = Enum.frequencies(right)

    Enum.reduce(left, 0, fn l, acc ->
      acc + l * Map.get(right_freq, l, 0)
    end)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn line, {acc1, acc2} ->
      [x, y] = String.split(line, " ", trim: true)
      {[String.to_integer(x) | acc1], [String.to_integer(y) | acc2]}
    end)
  end
end
