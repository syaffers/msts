class AddMemberToTicket < ActiveRecord::Migration
  def up
  	add_column :tickets, :member, :boolean, default: true
  end

  def down
  	remove_column :tickets, :member
  end
end
