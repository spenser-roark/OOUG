class Region < ActiveRecord::Base
self.pluralize_table_names = false

has_many :games
has_many :accessories

end
