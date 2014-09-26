module GamesWishListHelper

  def current_games_wish_list_ownership(id)
    @current_games_wish_list_ownership ||= GamesWishList.find_by(id: id)
  end

  def in_wish_list(game)
    @inWish = GamesWishList.find_by(user_id: current_user().id, games_id: game.id)
  end

  def wish_list_game(game)
    @user = User.find_by(remember_token: @remember_token)
    @ownership_game = GamesWishList.find_by(user_id: current_user, games_id: game)
  end

  def current_user
    remember_token = User.hash_token(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end


end
