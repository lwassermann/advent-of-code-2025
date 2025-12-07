defmodule Day06Test do
  use ExUnit.Case

  import Day06

  test "power example input" do
    # This example needs trailing whitespaces
    example =
      """
      123 328  51 64 
       45 64  387 23 
        6 98  215 314
      *   +   *   +
      """

    assert example
           |> calculate_columns()
           |> Enum.sum() == 4_277_556

    assert example |> calculate_transposed_columns() |> Enum.sum() == 3_263_827
  end
end
