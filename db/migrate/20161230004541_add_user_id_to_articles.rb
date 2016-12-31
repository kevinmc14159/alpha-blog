class AddUserIdToArticles < ActiveRecord::Migration
  def change
    # Add foreign key in articles table linking articles to users
    add_column :articles, :user_id, :integer
  end
end
