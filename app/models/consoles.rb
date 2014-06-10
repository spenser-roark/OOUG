class Consoles < ActiveRecord::Base

  belongs_to :console_general
  belongs_to :region
  belongs_to :image
  has_many :console_ownership
  has_many :users, through: :console_ownerships

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

  validates :ean, presence: true, length: {minimum: 12},
  uniqueness: { case_sensitive: false}

  validates :region_id, presence: true

  validates :eng_title, presence: true

  validates :console_general_id, presence: true

  validates :jap_title, presence: true, :if => :japanese?


Consoles.joins(:region, :console_general, :image)

end
