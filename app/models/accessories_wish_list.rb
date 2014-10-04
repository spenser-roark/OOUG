class AccessoriesWishList < ActiveRecord::Base
	self.pluralize_table_names = false

	belongs_to :accessories
	belongs_to :user

	AcccessoriesWishList.joins(:user, :accessories)
end
