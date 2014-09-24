class GamesWishList < ActiveRecord::Base
  self.pluralize_table_names = false

  belongs_to :games
  belongs_to :user

  GamesWishList.joins(:user, :games)
end
