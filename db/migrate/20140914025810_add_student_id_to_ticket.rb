class AddStudentIdToTicket < ActiveRecord::Migration
  def up
  	add_column :tickets, :student_id, :integer
  end

  def down
  	remove_column :tickets, :student_id
  end
end
