class AddTicketRangeToEvents < ActiveRecord::Migration
  def up
  	add_column :events, :starting_serial, :integer
  	add_column :events, :ending_serial, :integer
  end

  def down
  	remove_column :events, :starting_serial
  	remove_column :events, :ending_serial
  end
end
