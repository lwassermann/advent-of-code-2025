defmodule Day10Test do
  use ExUnit.Case

  import Day10

  test "parse_machine" do
    assert parse_machine("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}") == %{
             initialization_indicator_lights: [false, true, true, false],
             buttons: [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]],
             joltages: [3, 5, 4, 7]
           }

    assert parse_machine("[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}") == %{
             initialization_indicator_lights: [false, false, false, true, false],
             buttons: [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]],
             joltages: [7, 5, 12, 7, 2]
           }

    assert parse_machine("[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}") == %{
             initialization_indicator_lights: [false, true, true, true, false, true],
             buttons: [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]],
             joltages: [10, 11, 11, 5, 10, 5]
           }
  end

  test "example input" do
    example =
      """
      [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
      [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
      [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
      """

    machines = example |> parse_machines()
    assert machines |> find_shortest_activation_sequences() == [2, 3, 2]
  end
end
