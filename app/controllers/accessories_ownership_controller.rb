class AccessoriesOwnershipController < ApplicationController
  before_action :signed_in_user

  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  def show
    @accessory = AccessoriesOwnership.find_by(id: params[:id])
    @user = User.find_by(remember_token: cookies[:remember_token])
  end

  def new
    @ownership = AccessoriesOwnership.new
    @accessory = Accessories.find_by(id: params[:id])
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
    @quality_array.insert(0, "")
  end

  def create
    @user = User.find_by(remember_token: cookies[:remember_token])

    @ownership = AccessoriesOwnership.new(user_id: current_user().id, 
                                    accessories_id: params[:accessories_ownership][:accessories_id],
                                    own: 1, 
                                    complete: params[:accessories_ownership][:complete], 
                                    box_condition: params[:accessories_ownership][:box_condition], 
                                    item_condition: params[:accessories_ownership][:item_condition], 
                                    manual_condition: params[:accessories_ownership][:manual_condition], 
                                    inserts_condition: params[:accessories_ownership][:inserts_condition], 
                                    notes: params[:accessories_ownership][:notes])
    if @ownership.save
      redirect_to @ownership
    else

    end    

  end

  def edit
    @ownership = AccessoriesOwnership.find(params[:id])
    @accessory = Accessories.find(AccessoriesOwnership.find(params[:id]).accessories_id)
    @quality_array = Quality.all.map {|quality| [quality.quality, quality.id]}
    @quality_array.insert(0, "")
  end

  def update
    @ownership = AccessoriesOwnership.find(params[:id])
    @accessory = Accessories.find(AccessoriesOwnership.find(params[:id]).accessories_id)
    if @ownership.update_attributes(user_id: current_user().id, 
                                    accessories_id: AccessoriesOwnership.find(params[:id]).accessories_id, 
                                    own: 1, 
                                    complete: params[:accessories_ownership][:complete], 
                                    box_condition: params[:accessories_ownership][:box_condition], 
                                    item_condition: params[:accessories_ownership][:item_condition], 
                                    manual_condition: params[:accessories_ownership][:manual_condition], 
                                    inserts_condition: params[:accessories_ownership][:inserts_condition], 
                                    notes: params[:accessories_ownership][:notes])
      flash[:success] = @accessory.eng_title + " Successfully Updated"
      redirect_to @ownership
   else
      render 'edit'
   end

  end

  def destroy
    AccessoriesOwnership.delete(params[:id])
    redirect_to inventory_accessories_path(current_user)
  end

  private
  def ownership_params
    params.require(:ownership).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
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

    def correct_user
      @user = User.find(AccessoriesOwnership.find(params[:id]).user_id)
      redirect_to current_user, notice: "Sorry, you can't edit someone else's inventory"  unless current_user?(@user)
    end 

end
