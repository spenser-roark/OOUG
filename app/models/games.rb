class Games < ActiveRecord::Base
  belongs_to :console_general
  belongs_to :region
  belongs_to :image
  has_many :ownership
  has_many :users, through: :ownerships
  
  # scope :with_ownerships, -> { joins(:ownership) }
  # scope :with_certain_owner, -> { |owner_id| joins(:ownership).where(user_id: owner_id) }
  
  Games.joins(:region, :console_general, :image)
end
