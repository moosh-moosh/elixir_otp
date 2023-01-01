defmodule Counter.Server do
  @moduledoc """
  Server is just a process that exposes a service layer.
  Don't get hung up in today's baggage about the name.

  Save state by running a loop , with each iteration of the loop
  containing the new state.

  In the midst of our loop, we invite users to send a message to our server,
  a message which may change the state.
  """

  def run(count) do
    new_count = listen(count)
    run(new_count)
  end

  # The receive block allows us to interact with the server at each
  # iteration of the loop.
  # Send state message back to the server and return the count.
  def listen(count) do
    receive do
      {:tick, _pid} ->
        Counter.Core.inc(count)

      {:state, pid} ->
        send(pid, {:count, count})
        count
    end
  end
end
