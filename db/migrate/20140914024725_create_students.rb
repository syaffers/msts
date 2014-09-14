class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :contact_number
      t.string :student_id

      t.timestamps
    end
  end
end
