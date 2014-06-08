class StatsController < ApplicationController

  def index
    @game_count = Games.count(:all)
    @console_count = Consoles.count(:all)
    @accessory_count = Accessories.count(:all)
  end

end
