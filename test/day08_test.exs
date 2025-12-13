defmodule Day08Test do
  use ExUnit.Case

  import Day08

  test "distance calculation" do
    assert calculate_distances(%{
             2 => %{id: 2, position: {0, 0, 0}, circuit_id: 1},
             5 => %{id: 5, position: {2, 0, 0}, circuit_id: 2},
             10 => %{id: 10, position: {0, 4, 0}, circuit_id: 3}
           }) == [
             {2.0, {2, 5}},
             {4.0, {2, 10}},
             {4.47213595499958, {5, 10}}
           ]
  end

  test "example input" do
    example =
      """
      162,817,812
      57,618,57
      906,360,560
      592,479,940
      352,342,300
      466,668,158
      542,29,236
      431,825,988
      739,650,466
      52,470,668
      216,146,977
      819,987,18
      117,168,530
      805,96,715
      346,949,466
      970,615,88
      941,993,340
      862,61,35
      984,92,344
      425,690,689
      """

    assert example |> parse_lights() |> connect_shortest(10) |> guestimate_size() == 40
  end
end
