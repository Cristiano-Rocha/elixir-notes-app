defmodule NoteApp.Notes.NoteServer do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def all_notes(pid) do
    GenServer.call(pid, :all_notes)
  end


  # Client
  def create_note(note) do
    GenServer.cast(__MODULE__, {:create_note, note})
  end

  def get_note(id) do
    GenServer.call(__MODULE__, {:get_note, id})
  end

  def delete_note(pid, id) do
    GenServer.cast(__MODULE__, {:delete_note, id})
  end

  def update_note(pid, note) do
    GenServer.cast(__MODULE__, {:update_note, note})
  end

  #Server
  @impl true
  def init(notes) do
    {:ok, notes}
  end

  @impl true
  def handle_call(:all_notes, _from, notes) do
    {:reply, notes, notes}
  end

  @impl true
  def handle_cast({:create_note, note}, notes) do
    update_note = add_id(notes, note)
    update_notes = [update_note | notes]
    {:noreply, update_notes}
  end

  @impl true
  def handle_cast({:update_note, note}, notes) do
    update_notes = update_in(notes, [Access.filter(& &1.id == note.id)], fn _ -> note end)
  end

  @impl true
  def handle_call({:get_note, id}, _from, notes) do
    found_note = notes |> Enum.filter(fn note -> Map.get(note, :id) == id end |> List.first)
    {:reply, found_note, notes}
  end

  @impl true
  def handle_cast({:delete_note, id}, notes) do
    update_notes = notes |> Enum.reject(fn note -> Map.get(note, :id) == id end)
    {:noreply, update_notes}
  end

  defp add_id(notes, note) do
    id = (notes |> Kernel.length) + 1
    %{note | id: id}
  end


end
