class ConsoleGeneral < ActiveRecord::Base
  self.pluralize_table_names = false

  # scope :with_owned_games, -> { joins(:games).merge(Games.with_ownerships) }

  has_many :games
  has_many :accessories
end
