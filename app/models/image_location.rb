class ImageLocation < ActiveRecord::Base
self.pluralize_table_names = false

has_many :image

end
