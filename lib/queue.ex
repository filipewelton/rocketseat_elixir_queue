defmodule Queue do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:enqueue, value}, state) do
    {:noreply, [value] ++ state}
  end

  @impl true
  def handle_call(:dequeue, _from, state) when state == [], do: {:reply, nil, []}

  @impl true
  def handle_call(:dequeue, _from, [head | tail]), do: {:reply, head, tail}

  def enqueue(value) do
    GenServer.cast(__MODULE__, {:enqueue, value})
  end

  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
