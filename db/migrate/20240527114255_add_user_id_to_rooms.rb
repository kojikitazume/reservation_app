class AddUserIdToRooms < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:rooms, :user_id)
      add_reference :rooms, :user, null: false, foreign_key: true
    end
    unless column_exists?(:reservations, :user_id)
      add_reference :reservations, :user, null: false, foreign_key: true
    end
  end
end
