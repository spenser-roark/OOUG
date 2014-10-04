class AccessoriesWishListController < ApplicationController
  before_action :signed_in_user

  before_action :correct_user,   only: [:edit, :update, :show, :destroy, :edit]

  # def show
  #   @wish_list = AccessoriesWishList.find_by(user_id: params[:id])
  #   @game = AccessoriesWishList.find(params[:id])
  # end

  def index
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    @wish_list = AccessoriesWishList.find_by(user_id: current_user())
    @game = AccessoriesWishList.joins(:user).where(:users => {:id => current_user()})

    @gameConsoles = AccessoriesWishList.where(user_id: @user).joins(:accessories => :console_general).order("eng_name").uniq.pluck(:eng_name)

    if (params.has_key?(:console_id))
      @game = AccessoriesWishList.where(user_id: current_user().id).joins(:accessories => :console_general).where(:console_general => {:eng_name => params[:console_id]})

    else
      @game = AccessoriesWishList.joins(:user).where(:users => {:id => current_user()})

    end
    
    @image = Image.all

  end

  # def new
  #   @game = AccessoriesWishList.new
  #   @overgame = Accessories.find(params[:id])
  # end

  # def edit
  #   @game = AccessoriesWishList.find(params[:id])
  #   @overgame = AccessoriesWishList.where(id: params[:id]).joins(:accessories)
  # end

  # def create
  #   @user = User.find_by(remember_token: cookies[:remember_token])

  #   @wishlist = AccessoriesWishList.new(user_id: current_user().id, accessories_id: params[:accessories_wish_list][:accessories_id], notes: params[:accessories_wish_list][:notes])

  #   if @wishlist.save
  #     redirect_to @wishlist
  #   else

  #   end    
  # end

  # def update
  #   @game = AccessoriesWishList.find(params[:id])
  #   if @game.update_attributes(user_id: current_user().id, accessories_id: params[:accessories_wish_list][:accessories_id], notes: params[:accessories_wish_list][:notes])
  #     redirect_to @game
  #   else
  #     render "edit"
  #   end    
  # end

  # def destroy
  #   AccessoriesWishList.delete(params[:id])
  #   redirect_to accessories_wish_list_index_path
  # end

  private
  def wish_list_params
    params.require(:accessories_wish_list).permit(@user.id, :accessories_id, :notes)
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
      @user = User.find(AccessoriesWishList.find(params[:id]).user_id)
      redirect_to current_user, notice: "Sorry, you can't edit someone else's wish list"  unless current_user?(@user)
    end 

end
