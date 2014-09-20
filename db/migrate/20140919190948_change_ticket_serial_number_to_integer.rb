class ChangeTicketSerialNumberToInteger < ActiveRecord::Migration
  def up
  	change_column :tickets, :serial_number, :integer
  end

  def down
  	change_column :tickets, :serial_number, :string
  end 
end
