class Accessories < ActiveRecord::Base
  belongs_to :console_general
  belongs_to :region
  has_many :accessories_ownership
  has_many :users, through: :accessories_ownerships

  def japanese?
    region_id == 1
  end

  def clearJap
    self.jap_title = ""
  end

  def notJap
    region_id != 1
  end

  before_save :clearJap, :if => :notJap

  validates :accessories_ean, presence: true, length: {minimum: 12},
  uniqueness: { case_sensitive: false}

  validates :region_id, presence: true

  validates :eng_title, presence: true

  validates :console_general_id, presence: true

  validates :jap_title, presence: true, :if => :japanese?

  Accessories.joins(:region, :console_general)
end
