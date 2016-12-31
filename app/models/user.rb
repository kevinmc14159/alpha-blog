class User < ActiveRecord::Base
  # Establish Active Record Association
  has_many :articles, dependent: :destroy

  # Downcase emails before storing to database
  before_save { self.email = email.downcase }

  # Username validation
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }

  # Password validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, 
            uniqueness: { case_sensitive: false }, 
            format: { with: VALID_EMAIL_REGEX }

  # Enable passwords for users via one way hash digest
  has_secure_password
end
