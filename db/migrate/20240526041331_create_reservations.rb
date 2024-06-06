class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      #t.datetime :created_at

      t.timestamps
    end
  end
end
