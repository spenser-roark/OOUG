module ConsoleOwnershipHelper

  def ownership_console(console)
    @user = User.find_by(remember_token: @remember_token)
    @ownership_console = ConsoleOwnership.find_by(user_id: current_user, consoles_id: console)
  end

  def current_console_ownership(id)
    @current_console_ownership ||= ConsoleOwnership.find_by(id: id)
  end

end
