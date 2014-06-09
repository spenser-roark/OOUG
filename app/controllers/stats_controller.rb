class StatsController < ApplicationController

  before_action :signed_in_user

  before_action :correct_user

  def index
    @game_count = Games.count(:all)
    @console_count = Consoles.count(:all)
    @accessory_count = Accessories.count(:all)
  end

  private

  def correct_user
    redirect_to root_path unless admin?
  end 

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end


end
