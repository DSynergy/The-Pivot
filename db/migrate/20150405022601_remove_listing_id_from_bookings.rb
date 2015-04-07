class RemoveListingIdFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :listing_id, :integer
  end
end
