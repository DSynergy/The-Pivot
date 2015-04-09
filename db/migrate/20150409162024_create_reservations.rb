class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :listing_id
      t.integer :booking_id
      t.integer :user_id
      t.integer :status
      t.string :start_date
      t.string :end_date
    end
  end
end
