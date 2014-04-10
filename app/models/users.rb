class Users < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :alias,  presence: true, length: { maximum: 50 },
  uniqueness: { case_sensitive: false }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }

  has_many :ownership
  has_many :games, through: :ownerships

end
