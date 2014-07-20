class GamesWishListController < ApplicationController

  def show
    @wish_list = GamesWishList.find_by(user_id: params[:id])
    @game = GamesWishList.find(params[:id])
  end

  def index
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    @wish_list = GamesWishList.find_by(user_id: current_user())
    @game = GamesWishList.joins(:user).where(:users => {:id => current_user()})

    @gameConsoles = GamesWishList.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)
  end

  def new
    @game = GamesWishList.new
    @overgame = Games.find(params[:id])
  end

  def edit
    @game = GamesWishList.find(params[:id])
    @overgame = GamesWishList.where(id: params[:id]).joins(:games)
  end

  def create
    @user = User.find_by(remember_token: cookies[:remember_token])

    @wishlist = GamesWishList.new(user_id: current_user().id, games_id: params[:games_wish_list][:games_id], notes: params[:games_wish_list][:notes])

    if @wishlist.save
      redirect_to @wishlist
    else

    end    
  end

  def update
    @game = GamesWishList.find(params[:id])
    if @game.update_attributes(user_id: current_user().id, games_id: params[:games_wish_list][:games_id], notes: params[:games_wish_list][:notes])
      redirect_to @game
    else
      render "edit"
    end    
  end

  def destroy
    GamesWishList.delete(params[:id])
    redirect_to games_wish_list_index_path
  end

  private
  def wish_list_params
    params.require(:GamesWishList).permit(:user_id, :games_id, :notes)
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
      @user = User.find(Ownership.find(params[:id]).user_id)
      redirect_to current_user, notice: "Sorry, you can't edit someone else's inventory"  unless current_user?(@user)
    end 


end
