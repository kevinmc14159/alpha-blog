class Category < ActiveRecord::Base

  # Establish Active Record Association
  has_many :article_categories
  has_many :articles, through: :article_categories

  # All categories created must follow these rules
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  
end
