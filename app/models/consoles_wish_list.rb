class ConsolesWishList < ActiveRecord::Base
self.pluralize_table_names = false

	belongs_to :consoles
	belongs_to :user

	ConsolesWishList.joins(:user, :consoles)
end
