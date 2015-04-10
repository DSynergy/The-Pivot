class RemoveStatusfromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :status
    remove_column :bookings, :cart
    add_column :bookings, :trip_name, :text
  end
end
