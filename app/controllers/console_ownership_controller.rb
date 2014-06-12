class ConsoleOwnershipController < ApplicationController
  before_action :signed_in_user, only: [:edit, :show, :update, :new]

  def show
    @console = ConsoleOwnership.find_by(id: params[:id])
    @user = User.find_by(remember_token: cookies[:remember_token])
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
    @ownership = ConsoleOwnership.find(params[:id])
    @console = Consoles.find(ConsoleOwnership.find(params[:id]).consoles_id)
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
    @quality_array.insert(0, "")
  end

  def update
    @ownership = ConsoleOwnership.find(params[:id])
    @console = Consoles.find(ConsoleOwnership.find(params[:id]).consoles_id)
    if @ownership.update_attributes(user_id: current_user().id, 
                                    consoles_id: ConsoleOwnership.find(params[:id]).consoles_id, 
                                    own: 1, 
                                    complete: params[:console_ownership][:complete], 
                                    box_condition: params[:console_ownership][:box_condition], 
                                    console_condition: params[:console_ownership][:console_condition], 
                                    manual_condition: params[:console_ownership][:manual_condition], 
                                    inserts_condition: params[:console_ownership][:inserts_condition], 
                                    notes: params[:console_ownership][:notes])
      flash[:success] = @console.eng_name + " Successfully Updated"
      redirect_to @ownership
   else
    render 'edit'
   end

  end

  def destroy
    ConsoleOwnership.delete(params[:id])
    redirect_to inventory_path(current_user)
  end

  private
  def ownership_params
    params.require(:ownership).permit(:ean, :eng_name, :jap_name, :system, :region, :image)
  end

  def delete_params
    params.require(:ownership).permit(:id, :ean, :eng_title, :jap_title, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end
end
