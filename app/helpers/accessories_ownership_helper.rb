module AccessoriesOwnershipHelper

  def ownership_accessory(accessory)
    @user = User.find_by(remember_token: @remember_token)
    @ownership_accessory = AccessoriesOwnership.find_by(user_id: current_user, accessories_id: accessory)
  end

  def current_accessory_ownership(id)
    @current_accessory_ownership ||= AccessoriesOwnership.find_by(id: id)
  end

end
