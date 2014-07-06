module AccessoriesHelper

  def current_accessory=(accessory)
    @current_accessory = Accessories.find_by(id: accessory.id)
  end

  def in_accessory_collection(accessory)
    @inCollection = AccessoriesOwnership.find_by(user_id: current_user().id, accessories_id: accessory.id)
  end

  def current_accessory(accessory)
    @current_accessory = Accessories.find_by(id: accessory.id)
  end

end
