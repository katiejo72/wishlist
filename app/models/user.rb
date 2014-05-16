class User < ActiveRecord::Base
	before_save { email.downcase! }

	validates :fname, presence: true, length: { maximum: 20 }
	validates :lname, presence: true, length: { maximum: 20 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }, confirmation: true

  validates :password_confirmation, presence: true
end
