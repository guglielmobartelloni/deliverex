defmodule Deliverex.PostalCode.Postman do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def deliver_package(packages) do
    GenServer.cast(__MODULE__, {:deliver_package, packages})
  end

  def handle_cast({:deliver_package, [package | rest]}, _state) do
    do_deliver_package(package)
    {:noreply, rest}
  end

  defp do_deliver_package(%{distance: distance}) do
    Enum.each(0..distance, fn e ->
      IO.puts("Processing.. #{e}")
      :timer.sleep(100)
      {:ok, e - 10}
    end)
    IO.puts("Delivered package.")
  end
end
