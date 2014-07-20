module GamesHelper

  def current_game(game)
    @current_game = Games.find_by(id: game.id)
  end

  def in_collection(game)
    @inCollection = Ownership.find_by(user_id: current_user().id, games_id: game.id)
  end

  def current_game=(game)
    @current_game = Games.find_by(id: game.id)
  end

end
