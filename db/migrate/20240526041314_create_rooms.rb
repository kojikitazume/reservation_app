class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.datetime :checkin_date
      t.datetime :checkout_date
      t.timestamps
    end
  end
end