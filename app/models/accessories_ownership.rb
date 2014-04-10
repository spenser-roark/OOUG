class AccessoriesOwnership < ActiveRecord::Base
self.pluralize_table_names = false

belongs_to :accessories
belongs_to :user

AccessoriesOwnership.joins(:accessories, :user)

end
