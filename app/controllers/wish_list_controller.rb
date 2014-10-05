class WishListController < ApplicationController
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

end
