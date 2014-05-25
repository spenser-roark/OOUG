class BrowseController < ApplicationController

  def index
    @console = ConsoleGeneral.order("eng_name").uniq.pluck(:eng_name)
  end

  def show
    @console_games = Games.joins(:console_general).where(:console_general => {:eng_name => params[:id]})
    @console_name = ConsoleGeneral.find_by(eng_name: params[:id])
  end

end
