class Quality < ActiveRecord::Base
self.pluralize_table_names = false

has_many :box_qualities, :class_name => "Ownership", :foreign_key => "box_condition"
has_many :game_qualities, :class_name => "Ownership", :foreign_key => "game_condition"
has_many :manual_qualities, :class_name => "Ownership", :foreign_key => "manual_condition"
has_many :inserts_qualities, :class_name => "Ownership", :foreign_key => "inserts_condition"
has_many :spine_card_qualities, :class_name => "Ownership", :foreign_key => "spine_card_condition"

end
