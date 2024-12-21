defmodule Deliverex.PostalCode.Store do
  alias Deliverex.PostalCode.DataParser
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> DataParser.parse_data end, name: __MODULE__)
  end

  def get_geolocation(postal_code) do
    Agent.get(__MODULE__, fn geolocation_data -> Map.get(geolocation_data, postal_code) end)
  end

end
