class OwnershipController < ApplicationController

  before_action :signed_in_user, only: [:edit, :show, :update, :new]

  def show
    @game = Ownership.find_by(id: params[:id])
    @user = User.find_by(remember_token: cookies[:remember_token])
    # @box_condition = Ownership.where(id: params[:id]).joins(:quality)
  end

  def new
    @ownership = Ownership.new
    @game = Games.find_by(id: params[:id])
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
    @quality_array.insert(0, "")
  end
  
  def create
    @user = User.find_by(remember_token: cookies[:remember_token])

    @ownership = Ownership.new(user_id: current_user().id, games_id: params[:ownership][:games_id], own: 1, complete: params[:ownership][:complete], box_condition: params[:ownership][:box_condition], game_condition: params[:ownership][:game_condition], manual_condition: params[:ownership][:manual_condition], inserts_condition: params[:ownership][:inserts_condition], notes: params[:ownership][:notes], spine_card_condition: params[:ownership][:spine_card_condition], count: 1)

    if @ownership.save
      redirect_to @ownership
    else
      
    end    
  end

  def edit
  end

  def destroy
    # Ownership.delete(user_id: current_user().id, games_id: )
  end

  def update
  end

  private
  def ownership_params
    params.require(:ownership).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end


end
