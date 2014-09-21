class AddRolesMaskToAdmins < ActiveRecord::Migration
  def up
  	add_column :admins, :roles_mask, :integer
  end

  def down
  	remove_column :admins, :roles_mask
  end
end
