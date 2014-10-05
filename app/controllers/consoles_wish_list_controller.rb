class ConsolesWishListController < ApplicationController
before_action :signed_in_user

  before_action :correct_user,   only: [:edit, :update, :show, :destroy, :edit]

  def show
    @wish_list = ConsolesWishList.find_by(user_id: params[:id])
    @game = ConsolesWishList.find(params[:id])
  end

  def index
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    @wish_list = ConsolesWishList.find_by(user_id: current_user())
    @game = ConsolesWishList.joins(:user).where(:users => {:id => current_user()})

    @gameConsoles = ConsolesWishList.where(user_id: @user).joins(:consoles => :console_general).order("eng_name").uniq.pluck(:eng_name)

    if (params.has_key?(:console_id))
      @game = ConsolesWishList.where(user_id: current_user().id).joins(:consoles => :console_general).where(:console_general => {:eng_name => params[:console_id]})

    else
      @game = ConsolesWishList.joins(:user).where(:users => {:id => current_user()})

    end
    
    @image = Image.all

  end

  def new
    @game = ConsolesWishList.new
    @overgame = Consoles.find(params[:id])
  end

  def edit
    @game = ConsolesWishList.find(params[:id])
    @overgame = ConsolesWishList.where(id: params[:id]).joins(:consoles)
  end

  def create
    @user = User.find_by(remember_token: cookies[:remember_token])

    @wishlist = ConsolesWishList.new(user_id: current_user().id, consoles_id: params[:consoles_wish_list][:consoles_id], notes: params[:consoles_wish_list][:notes])

    if @wishlist.save
      redirect_to @wishlist
    else

    end    
  end

  def update
    @game = ConsolesWishList.find(params[:id])
    if @game.update_attributes(user_id: current_user().id, consoles_id: params[:consoles_wish_list][:consoles_id], notes: params[:consoles_wish_list][:notes])
      redirect_to @game
    else
      render "edit"
    end    
  end

  def destroy
    ConsolesWishList.delete(params[:id])
    redirect_to wish_list_consoles_path(current_user)
  end

  private
  def wish_list_params
    params.require(:consoles_wish_list).permit(@user.id, :consoles_id, :notes)
  end

  def delete_params
    params.require(:ownership).permit(:id, :ean, :eng_name, :jap_name, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(ConsolesWishList.find(params[:id]).user_id)
      redirect_to current_user, notice: "Sorry, you can't edit someone else's wish list"  unless current_user?(@user)
    end 
end
