module ConsolesHelper

  def current_console(console)
    @current_console = Console.find_by(id: console.id)
  end

  def in_collection(console)
    @inCollection = ConsoleOwnership.find_by(user_id: current_user().id, console_id: console.id)
  end

end
