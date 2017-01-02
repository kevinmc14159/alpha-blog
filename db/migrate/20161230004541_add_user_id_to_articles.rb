class AddUserIdToArticles < ActiveRecord::Migration

  def change
    # Adding columns to table: Table name, attribute name, attribute type
    # Add foreign key in articles table linking articles to users
    add_column :articles, :user_id, :integer
  end
  
end
