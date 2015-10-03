class User < ActiveRecord::Base
  before_save :downcase_email

  has_secure_password

  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }

  def downcase_email
  	self.email = email.downcase
  end

end