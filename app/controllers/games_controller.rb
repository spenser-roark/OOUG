class GamesController < ApplicationController

  def show
    @game = Games.find(params[:id])
  end

  def new
    @game = Games.new
  end
  
  def create
    @game = Games.new(game_params)    
    if @game.save
      redirect_to @game
    else
    end    
  end
  
  private
  
  def game_params
    params.require(:games).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
  end
  
end
