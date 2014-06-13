class Ownership < ActiveRecord::Base
  self.pluralize_table_names = false

  belongs_to :games
  belongs_to :user

  belongs_to :box_qualities, :class_name => "Quality", :foreign_key => "box_condition"
  belongs_to :game_qualities, :class_name => "Quality", :foreign_key => "game_condition"
  belongs_to :manual_qualities, :class_name => "Quality", :foreign_key => "manual_condition"
  belongs_to :inserts_qualities, :class_name => "Quality", :foreign_key => "inserts_condition"
  belongs_to :spine_card_qualities, :class_name => "Quality", :foreign_key => "spine_card_condition"

  validates :box_qualities, presence: true
  validates :game_qualities, presence: true
  validates :manual_qualities, presence: true
  validates :inserts_qualities, presence: true
  validates :spine_card_qualities, presence: true

  Ownership.joins(:games, :user, :quality)
end
