class Consoles < ActiveRecord::Base

  belongs_to :console_general
  belongs_to :region
  belongs_to :image
  has_many :console_ownership
  has_many :users, through: :console_ownerships

Consoles.joins(:region, :console_general, :image)

end
