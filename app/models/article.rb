# Article model
class Article < ActiveRecord::Base

  # Forces articles to have a title & description
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

end