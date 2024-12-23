defmodule Deliverex.PostalCode.Supervisor do
  alias Deliverex.PostalCode.Postman
  alias Deliverex.PostalCode.Navigator
  alias Deliverex.PostalCode.Store
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      Navigator,
      Store,
      Postman
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
