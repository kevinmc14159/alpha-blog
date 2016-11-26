class AddDescriptionToArticles < ActiveRecord::Migration
  def change
    # Adding columns to table: Table name, attribute name, attribute type
    add_column :articles, :description, :text
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
  end
end
