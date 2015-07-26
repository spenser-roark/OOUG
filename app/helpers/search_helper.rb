module SearchHelper

  def search_string(string)
    @search_string = string
  end

  def in_collection(game)
    @inCollection = Ownership.find_by(user_id: current_user().id, games_id: game.id)
  end

  def in_acc_collection(accessory)
    @inCollection = AccessoriesOwnership.find_by(user_id: current_user().id, accessories_id: accessory.id)
  end

  def in_console_collection(console)
    @inCollection = ConsoleOwnership.find_by(user_id: current_user().id, consoles_id: console.id)
  end


end
