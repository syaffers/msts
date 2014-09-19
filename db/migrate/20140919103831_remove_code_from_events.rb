class RemoveCodeFromEvents < ActiveRecord::Migration
  def up
  	remove_column :events, :code
  end

  def down
  	add_column :events, :code, :string
  end
end
