class RenameTableOrderToBookings < ActiveRecord::Migration
  def self.up
    rename_table :orders, :bookings
  end

  def self.down
    rename_table :bookings, :orders
  end

end
