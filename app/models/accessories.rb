class Accessories < ActiveRecord::Base
  belongs_to :console_general
  belongs_to :region
  has_many :accessories_ownership
  has_many :users, through: :accessories_ownerships

Accessories.joins(:region, :console_general)
end
