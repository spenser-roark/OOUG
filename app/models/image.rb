class Image < ActiveRecord::Base
self.pluralize_table_names = false

has_many :games

belongs_to :image_location

Image.joins(:image_location)

end
