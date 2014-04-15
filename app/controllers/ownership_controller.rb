class OwnershipController < ApplicationController

  before_action :signed_in_user, only: [:edit, :show, :update]

  def show
    @game = Ownership.find_by(id: params[:id])
    # @box_condition = Ownership.where(id: params[:id]).joins(:quality)
  end

  def new
    @ownership = Ownership.new
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
  end
  
  def create
    @ownership = Ownership.new(game_params)    
    if @ownership.save
      redirect_to @ownership
    else
    end    
  end

  def edit
  end
  
  def update
  end

  private
  def ownership_params
    # params.require(:games).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end


end
