class AddAdminToUsers < ActiveRecord::Migration

  def change
    # Adding columns to table: Table name, attribute name, attribute type
    # Users are not admins by default
    add_column :users, :admin, :boolean, default: false
  end
  
end
