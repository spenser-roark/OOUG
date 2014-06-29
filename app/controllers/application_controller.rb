class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :sidebar_consoles

  def sidebar_consoles
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    @gameConsoles = Ownership.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)
    @consoleConsoles = ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general).order("eng_name").uniq.pluck("console_general.eng_name")
  end

private 

  
end
