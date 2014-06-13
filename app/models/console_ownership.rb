class ConsoleOwnership < ActiveRecord::Base
self.pluralize_table_names = false

  belongs_to :consoles
  belongs_to :user

  belongs_to :box_qualities, :class_name => "Quality", :foreign_key => "box_condition"
  belongs_to :console_qualities, :class_name => "Quality", :foreign_key => "console_condition"
  belongs_to :manual_qualities, :class_name => "Quality", :foreign_key => "manual_condition"
  belongs_to :inserts_qualities, :class_name => "Quality", :foreign_key => "inserts_condition"

  validates :box_qualities, presence: true
  validates :console_qualities, presence: true
  validates :manual_qualities, presence: true
  validates :inserts_qualities, presence: true

  ConsoleOwnership.joins(:consoles, :user, :quality)
end
