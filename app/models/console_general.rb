class ConsoleGeneral < ActiveRecord::Base
  self.pluralize_table_names = false

  validates :eng_name, presence: true

  validates :jap_name, presence: true

  has_many :games
  has_many :accessories
end
