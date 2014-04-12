module GamesHelper

  def current_game(game)
    @current_game = Games.find_by(id: game.id)
  end

end
