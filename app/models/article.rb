class Article < ActiveRecord::Base
  # Establish Active Record Association
  belongs_to :user

  # Forces articles to have a title & description of specified length
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 10_000 }
  # All created articles must have an author
  validates :user_id, presence: true

end
