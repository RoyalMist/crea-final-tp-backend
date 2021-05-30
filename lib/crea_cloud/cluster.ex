defmodule CreaCloud.Cluster do
  use GenServer
  require Logger

  @five_seconds 5_000

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, [init_args])
  end

  @impl true
  def init(_args) do
    master_node = :"api@#{Application.get_env(:crea_graphy, :master_ip)}"

    if Application.get_env(:crea_graphy, :clustering, false) do
      Logger.info("Cluster mode enabled")
      ping([master_node])
      Process.send_after(self(), :ping, @five_seconds)
    end

    {:ok, %{master: master_node, nodes: [master_node]}}
  end

  @impl true
  def handle_info(:ping, state) do
    state = %{state | nodes: [state.master | Node.list()]}
    ping(state.nodes)
    Process.send_after(self(), :ping, @five_seconds)
    {:noreply, state}
  end

  defp ping([]), do: :ok

  defp ping([h | t]) do
    case Node.ping(h) do
      :pang -> Logger.error("Unable to ping #{h}")
      :pong -> Logger.debug("Successfully ping #{h}")
    end

    ping(t)
  end
end
