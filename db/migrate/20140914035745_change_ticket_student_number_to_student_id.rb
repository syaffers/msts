class ChangeTicketStudentNumberToStudentId < ActiveRecord::Migration
  def up
    rename_column :tickets, :student_number, :student_id
  end

  def down
    rename_column :tickets, :student_id, :student_number
  end
end
