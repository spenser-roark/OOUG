module SearchHelper

  def search_string(string)
    @search_string = string
  end

  def in_collection(game)
    @inCollection = Ownership.find_by(user_id: current_user().id, games_id: game.id)
  end

end
