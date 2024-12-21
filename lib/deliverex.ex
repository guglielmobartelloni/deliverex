defmodule Deliverex do
  use Application

  def start(_start_type, _start_args) do
    Deliverex.Supervisor.start_link()
  end


end
