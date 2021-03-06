defmodule Om.Joob do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end


  def handle_info(:work, state) do

    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
      Process.send_after(self(), :work, 1 * 1000) # 2 second
  end
end