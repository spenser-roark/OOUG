module OwnershipHelper

  def ownership_game(game)
    @user = User.find_by(remember_token: @remember_token)
    @ownership_game = Ownership.find_by(user_id: @user, games_id: game)
     end

  def current_ownership(id)
    @current_ownership ||= Ownership.find_by(id: id)
  end

end
