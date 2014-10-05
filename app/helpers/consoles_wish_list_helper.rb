module ConsolesWishListHelper
def current_consoles_wish_list_ownership(id)
		@current_consoles_wish_list_ownership ||= ConsolesWishList.find_by(id: id)
	end

	def in_consoles_wish_list(game)
		@inWish = ConsolesWishList.find_by(user_id: current_user().id, consoles_id: game.id)
	end

	def wish_list_console(game)
		@user = User.find_by(remember_token: @remember_token)
		@ownership_game = ConsolesWishList.find_by(user_id: current_user, consoles_id: game)
	end

	def current_user
		remember_token = User.hash_token(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
end
