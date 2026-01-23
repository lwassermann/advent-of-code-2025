defmodule Day10 do
  def run do
    machines =
      File.read!("data/day10.txt")
      |> parse_machines()

    machines |> find_shortest_activation_sequences() |> Enum.sum() |> IO.inspect()
  end

  def parse_machines(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_machine/1)
  end

  @spec parse_machine(binary()) :: %{
          buttons: list(),
          initialization_indicator_lights: list(),
          joltages: list()
        }
  def parse_machine(spec) do
    %{
      "init_indicator_lights_spec" => init_indicator_lights_spec,
      "buttons_spec" => buttons_spec,
      "joltage_spec" => joltage_spec
    } =
      Regex.named_captures(
        ~r/^\[(?<init_indicator_lights_spec>[\.\#]+)\] (?<buttons_spec>\(\d(,\d)*\)( \(\d(,\d)*\))*) {(?<joltage_spec>\d+(,\d+)*)}$/,
        spec
      )

    %{
      initialization_indicator_lights:
        init_indicator_lights_spec |> String.split("", trim: true) |> Enum.map(&(&1 == "#")),
      buttons: buttons_spec |> parse_buttons(),
      joltages: joltage_spec |> String.split(",") |> Enum.map(&String.to_integer(&1))
    }
  end

  def parse_buttons(buttons_spec) do
    buttons_spec
    |> String.split(" ")
    |> Enum.map(&parse_button/1)
  end

  def parse_button(button_spec) do
    button_spec
    |> String.replace(~r/[()]/, "")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def find_shortest_activation_sequences(machines) do
    machines |> Enum.map(&find_shortest_activation_sequence/1)
  end

  def find_shortest_activation_sequence(_machine) do
    2
  end
end

# Day10.run()
