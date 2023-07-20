class AddUserIdToRooms < ActiveRecord::Migration[7.0]
  def change
    # add user_id as a reference to rooms table
    add_reference :rooms, :user, null: false, foreign_key: true
  end
end
