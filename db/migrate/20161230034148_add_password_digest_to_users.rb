class AddPasswordDigestToUsers < ActiveRecord::Migration

  def change
    # Adding columns to table: Table name, attribute name, attribute type
    add_column :users, :password_digest, :string
  end
  
end
