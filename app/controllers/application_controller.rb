class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :sidebar_consoles
  before_action :signed_in_user, only: [:edit, :show, :update]

  def sidebar_consoles
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    if (params.has_key?(:console_id))
      @console = Ownership.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)

    else
      @console = Ownership.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)

    end
  end

private 

 # Before filters

    def signed_in_user
      redirect_to signIn_url, notice: "Please sign in." unless signed_in?
    end
 

end
