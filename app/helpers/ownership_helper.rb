module OwnershipHelper

  def ownership_game(game)
    @user = User.find_by(remember_token: @remember_token)
    # @ownership_game = Ownership.find_by(user_id: @user, games_id: game)#.joins(:games).where(:games => {:id => game})
    @ownership_game = Ownership.find_by(user_id: @user, games_id: game)#.joins(:games).where(:games => {:id => game})
    # @ownership = Ownership.find_by(games_id: 1)
     end

  def current_ownership(id)
    @current_ownership ||= Ownership.find_by(id: id)
  end

  # def options_for_conditions([['Great', 1], ['Good', 2]], 2)
  # end

end
