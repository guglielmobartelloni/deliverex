defmodule Deliverex.PostalCode.DataParser do
  @file_path "data/gi_comuni_cap.csv"

  def parse_data do
    [_header | rows] = File.read!(@file_path) |> String.split("\n", trim: true)

    rows
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.map(fn [_, _, _, _, postal_code, _, _, _, _, _, _, _, _, _, lat, lon, _] ->
      {postal_code, {String.to_float(lat), String.to_float(lon)}}
    end)
    |> Enum.into(%{})
  end
end
