# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(), do: start([])

  def start(opts) do
    Agent.start(fn -> {opts, 1} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {opts, _} -> opts end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {opts, id} ->
      plot = %Plot{plot_id: id, registered_to: register_to}
      {plot, {[plot | opts], id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {opts, id} ->
      {Enum.reject(opts, fn plot -> plot.plot_id == plot_id end), id}
    end)
  end

  def get_registration(pid, plot_id) do
    list_registrations(pid)
    |> Enum.find(
      {:not_found, "plot is unregistered"},
      &(Map.get(&1, :plot_id) == plot_id)
    )
  end
end
