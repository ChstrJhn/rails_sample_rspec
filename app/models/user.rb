class User < ActiveRecord::Base
  before_save :downcase_email
  before_create :create_remember_token

  has_many :microposts, dependent: :destroy

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }

  def feed
  	microposts
  end

  def downcase_email
  	self.email = email.downcase
  end

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
  	self.remember_token = User.digest(User.new_remember_token)
  end

end
