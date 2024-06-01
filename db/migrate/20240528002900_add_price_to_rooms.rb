class AddPriceToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :price, :integer
  end
end
