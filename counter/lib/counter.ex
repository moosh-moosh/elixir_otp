defmodule Counter do
  @moduledoc """
  Interact with processes.
  """

  def start(initial_count) do
    spawn(fn -> Counter.Server.run(initial_count) end)
  end

  # Sends a :tick message to the server,
  # which increments count by 1
  def tick(pid) do
    send(pid, {:tick, self()})
  end

  # Sends a :state message to the server, the server will in turn
  # send a response with the updated count: {:count, count}
  def state(pid) do
    send(pid, {:state, self()})

    receive do
      {:count, value} -> value
    end
  end
end
