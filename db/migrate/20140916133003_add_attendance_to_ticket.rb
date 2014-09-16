class AddAttendanceToTicket < ActiveRecord::Migration
  def up
  	add_column :tickets, :attendance, :boolean, default: false
  end

  def down
  	remove_column :tickets, :attendance
  end
end
