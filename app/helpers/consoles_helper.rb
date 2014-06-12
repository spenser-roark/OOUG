module ConsolesHelper

  def current_console(console)
    @current_console = Console.find_by(id: console.id)
  end

  def in_console_collection(console)
    @inCollection = ConsoleOwnership.find_by(user_id: current_user().id, consoles_id: console.id)
  end

end
