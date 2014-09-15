class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :code
      t.string :member_price
      t.string :non_member_price

      t.timestamps
    end
  end
end
