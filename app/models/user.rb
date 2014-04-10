class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :alias,  presence: true, length: { maximum: 50 },
  uniqueness: { case_sensitive: false }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

   def User.hash_token(token)
     Digest::SHA1.hexdigest(token.to_s)
  end

  has_many :ownership
  has_many :games, through: :ownerships

  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
