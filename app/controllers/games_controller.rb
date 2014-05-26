class GamesController < ApplicationController

  before_action :signed_in_user, only: [:new, :show]

  def show
    @game = Games.find(params[:id])
  end

  def new
    @game = Games.new
    @region_array = Region.all.map {|region| [region.region_title + " - " + region.region_country, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")

  end
  
  def create
    @region_array = Region.all.map {|region| [region.region_title + " - " + region.region_country, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")

    @game = Games.new(game_params)    
    if @game.save
      redirect_to @game
    else
      # flash.now[:error] = "Some fields were left blank"
      render "new"
    end    
  end
  
  private
  
  def game_params
    params.require(:games).permit(:ean, :eng_title, :jap_title, :console_general_id, :region_id, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end

  
end
