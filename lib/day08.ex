defmodule Day08 do
  def run do
    circuitry =
      File.read!("data/day08.txt")
      |> parse_lights()
      |> connect_shortest(1000)

    circuitry
    |> guestimate_size()
    |> IO.inspect()

    circuitry
    |> last_connection_product()
    |> IO.inspect()
  end

  def parse_lights(content) do
    lights = initialize_lights(content)
    circuits = initialize_circuits(map_size(lights) - 1)
    distances = calculate_distances(lights)

    %{lights: lights, circuits: circuits, distances: distances}
  end

  defp initialize_lights(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_coordinates/1)
    |> Enum.with_index()
    |> Enum.map(fn {coordinates, index} ->
      {index, %{id: index, position: coordinates, circuit_id: index}}
    end)
    |> Enum.into(%{})
  end

  defp initialize_circuits(number) do
    Range.new(0, number, 1)
    |> Enum.map(fn index ->
      {index, %{id: index, light_ids: [index]}}
    end)
    |> Enum.into(%{})
  end

  def calculate_distances(lights) do
    all_lights = Map.values(lights)

    all_lights
    |> Enum.flat_map(fn light -> calculate_distances(light, all_lights) end)
    |> Enum.sort_by(&elem(&1, 0))
  end

  defp calculate_distances(_, []), do: []

  defp calculate_distances(light_a, [light_b | rest]) when light_a.id >= light_b.id,
    do: calculate_distances(light_a, rest)

  defp calculate_distances(light_a = %{id: id_a, position: pos_a}, [
         %{id: id_b, position: pos_b} | rest
       ]) do
    [{calculate_distance(pos_a, pos_b), {id_a, id_b}} | calculate_distances(light_a, rest)]
  end

  defp calculate_distance({x1, y1, z1}, {x2, y2, z2}) do
    (Integer.pow(x2 - x1, 2) +
       Integer.pow(y2 - y1, 2) +
       Integer.pow(z2 - z1, 2)) **
      0.5
  end

  def connect_shortest(circuitry, number) do
    connect(circuitry, number, circuitry.distances)
  end

  defp connect(circuitry, 0, _), do: circuitry

  defp connect(_circuitry, _number, []),
    do: raise("Could not run that many wires. All lights are connected.")

  # All lights are connected in one big circuit
  defp connect(circuitry, _number, _distances) when map_size(circuitry.circuits) == 1,
    do: circuitry

  defp connect(circuitry, number, [{_, {from, to}} | rest]) do
    light_a = circuitry.lights[from]
    light_b = circuitry.lights[to]

    circuitry
    |> put_in([:last_connection], {light_a, light_b})
    |> merge_circuits(light_a.circuit_id, light_b.circuit_id)
    |> connect(number - 1, rest)
  end

  defp merge_circuits(circuitry, id_a, id_b) when id_a > id_b,
    do: merge_circuits(circuitry, id_b, id_a)

  defp merge_circuits(circuitry, id_a, id_a), do: circuitry

  defp merge_circuits(circuitry, id_a, id_b) do
    circuit_b_light_ids = get_circuit(circuitry, id_b).light_ids

    circuitry
    |> update_lights_to_circuit(id_a, circuit_b_light_ids)
    |> update_circuit_lights(id_a, circuit_b_light_ids)
    |> drop_circuit(id_b)
  end

  defp update_lights_to_circuit(circuitry, circuit_id, light_ids) do
    light_ids
    |> Enum.reduce(circuitry, fn light_id, circuitry ->
      put_in(circuitry, [:lights, light_id, :circuit_id], circuit_id)
    end)
  end

  defp update_circuit_lights(circuitry, circuit_id, new_light_ids) do
    circuitry
    |> update_in([:circuits, circuit_id, :light_ids], fn ids -> ids ++ new_light_ids end)
  end

  defp drop_circuit(circuitry, circuit_id) do
    circuitry
    |> pop_in([:circuits, circuit_id])
    |> elem(1)
  end

  defp get_circuit(circuitry, id), do: get_in(circuitry.circuits[id])

  def guestimate_size(circuitry) do
    circuitry.circuits
    |> Enum.map(fn {_, circuit} -> length(circuit.light_ids) end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def last_connection_product(circuitry) do
    circuitry = connect_shortest(circuitry, length(circuitry.distances))
    {a, b} = circuitry.last_connection
    elem(a.position, 0) * elem(b.position, 0)
  end

  defp parse_coordinates(coordinate_description) do
    coordinate_description
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> to_coord()
  end

  defp to_coord([x, y, z]), do: {x, y, z}
end

Day08.run()
