class Games < ActiveRecord::Base
  belongs_to :console_general
  belongs_to :region
  belongs_to :image
  has_many :ownership
  has_many :users, through: :ownerships
  
  # scope :with_ownerships, -> { joins(:ownership) }
  # scope :with_certain_owner, -> { |owner_id| joins(:ownership).where(user_id: owner_id) }

validates :ean, presence: true, length: {minimum: 12},
uniqueness: { case_sensitive: false}

validates :region_id, presence: true

validates :eng_title, presence: true

validates :console_general_id, presence: true
 
  Games.joins(:region, :console_general, :image)
end
