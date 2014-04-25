class OwnershipController < ApplicationController

  before_action :signed_in_user, only: [:edit, :show, :update]

  def show
    @game = Ownership.find_by(id: params[:id])
    @user = User.find_by(remember_token: cookies[:remember_token])
    # @box_condition = Ownership.where(id: params[:id]).joins(:quality)
  end

  def new
    @ownership = Ownership.new
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
    @quality_array.insert(0, "")
  end
  
  def create
    @ownership = Ownership.new(ownership_params)    
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
    params.require(:games).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end


end
