class WishListController < ApplicationController

	before_action :signed_in_user

	before_action :correct_user,   only: [:edit, :update, :show, :destroy, :edit]

	def games
		@remember_token = User.hash_token(cookies[:remember_token])
		@user = User.find_by(remember_token: @remember_token)

		@wish_list = GamesWishList.find_by(user_id: current_user())
		@game = GamesWishList.joins(:user).where(:users => {:id => current_user()})

		@gameConsoles = GamesWishList.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)

		if (params.has_key?(:console_id))
			@game = GamesWishList.where(user_id: current_user().id).joins(:games => :console_general).where(:console_general => {:eng_name => params[:console_id]})

		else
			@game = GamesWishList.joins(:user).where(:users => {:id => current_user()})

		end

		@image = Image.all

	end

	def accessories
	end

	private
	def wish_list_params
		params.require(:games_wish_list).permit(@user.id, :games_id, :notes)
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
 	@user = User.find(GamesWishList.find(params[:id]).user_id)
 	redirect_to current_user, notice: "Sorry, you can't edit someone else's wish list"  unless current_user?(@user)
 end 
 
end
