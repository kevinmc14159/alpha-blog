class ArticleCategory < ActiveRecord::Base

  # Establish Active Record Association
  belongs_to :article
  belongs_to :category
  
end
