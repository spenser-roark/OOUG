class StatsController < ApplicationController

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

end
