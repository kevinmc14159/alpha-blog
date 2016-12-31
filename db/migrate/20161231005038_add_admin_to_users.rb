class AddAdminToUsers < ActiveRecord::Migration
  def change
    # Users are not admins by default
    add_column :users, :admin, :boolean, default: false
  end
end
