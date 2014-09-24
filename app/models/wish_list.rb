class WishList <ActiveRecord::Base>
self.pluralize_table_names = false

validates :user_id, uniqueness: {:scope :games_id}

end
