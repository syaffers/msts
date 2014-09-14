class AddMemberToStudents < ActiveRecord::Migration
  def up
    add_column :students, :member, :boolean, default: true
  end

  def down
    remove_column :students, :member
  end 
end
