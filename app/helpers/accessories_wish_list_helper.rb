module AccessoriesWishListHelper
	def current_accessories_wish_list_ownership(id)
		@current_accessories_wish_list_ownership ||= AccessoriesWishList.find_by(id: id)
	end

	def in_accessories_wish_list(game)
		@inWish = AccessoriesWishList.find_by(user_id: current_user().id, accessories_id: game.id)
	end

	def wish_list_accessory(game)
		@user = User.find_by(remember_token: @remember_token)
		@ownership_game = AccessoriesWishList.find_by(user_id: current_user, accessories_id: game)
	end

	def current_user
		remember_token = User.hash_token(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
end
