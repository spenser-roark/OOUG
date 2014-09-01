class AccessoriesOwnership < ActiveRecord::Base
  self.pluralize_table_names = false

  belongs_to :accessories
  belongs_to :user

  belongs_to :box_qualities, :class_name => "Quality", :foreign_key => "box_condition"
  belongs_to :accessories_qualities, :class_name => "Quality", :foreign_key => "item_condition"
  belongs_to :manual_qualities, :class_name => "Quality", :foreign_key => "manual_condition"
  belongs_to :inserts_qualities, :class_name => "Quality", :foreign_key => "inserts_condition"

  validates :box_qualities, presence: true
  validates :accessories_qualities, presence: true
  validates :manual_qualities, presence: true
  validates :inserts_qualities, presence: true

  AccessoriesOwnership.joins(:accessories, :user, :quality)

end
