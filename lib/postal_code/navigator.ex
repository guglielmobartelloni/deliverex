defmodule Deliverex.PostalCode.Navigator do
  use GenServer
  alias Deliverex.PostalCode.Store
  alias :math, as: Math
  @radius 6371 

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_distance(from, to) do
    GenServer.call(__MODULE__, {:get_distance, from, to})
  end

  def handle_call({:get_distance, from, to}, _from, state) do
    distance = do_get_distance(from, to)
    {:reply, distance, state}
  end

  defp get_geolocation(postal_code) do
    Store.get_geolocation(postal_code)
  end

  defp do_get_distance(from, to) do

    {lat1, lon1} = get_geolocation(from)
    {lat2, lon2} = get_geolocation(to)

    distance = calculate_distance({lat1, lon1}, {lat2, lon2})
    distance
  end

  defp calculate_distance({lat1, long1}, {lat2, long2}) do
    lat_diff = degrees_to_radians(lat2 - lat1)
    long_diff = degrees_to_radians(long2 - long1)

    lat1 = degrees_to_radians(lat1)
    lat2 = degrees_to_radians(lat2)

    cos_lat1 = Math.cos(lat1)
    cos_lat2 = Math.cos(lat2)

    sin_lat_diff_sq = Math.sin(lat_diff / 2) |> Math.pow(2)
    sin_long_diff_sq = Math.sin(long_diff / 2) |> Math.pow(2)

    a = sin_lat_diff_sq + (cos_lat1 * cos_lat2 * sin_long_diff_sq)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    @radius * c |> Float.round(2)
  end

  defp degrees_to_radians(degrees) do
    degrees * (Math.pi / 180)
  end

end
