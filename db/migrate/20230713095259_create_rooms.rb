class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.text :description
      t.integer :num
      t.text :room_type
      t.float :night_cost
      t.text :image
      t.boolean :booked
      t.date :booked_end

      t.timestamps
    end
  end
end
