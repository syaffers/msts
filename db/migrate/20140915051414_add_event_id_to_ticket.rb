class AddEventIdToTicket < ActiveRecord::Migration
  def up
  	add_column :tickets, :event_id, :integer
  end

  def down
  	remove_column :tickets, :event_id
  end
end
