class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # rescue_from ActionController::ActionControllerError, :with => :page_not_found
  # rescue_from ActionController::RoutingError, :with => :page_not_found

  private 

  def not_found
  	redirect_to not_found_path
  end
  
end
