class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # rescue_from ActionController::ActionControllerError, :with => :page_not_found
  # rescue_from ActionController::RoutingError, :with => :page_not_found


  def page_not_found
  	respond_to do |format|
  		format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
  		format.all  { render nothing: true, status: 404 }
  	end
  end

  private 

  def not_found
  	redirect_to not_found_path
  end
  
end
