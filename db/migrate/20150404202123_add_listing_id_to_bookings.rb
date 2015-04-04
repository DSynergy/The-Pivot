class AddListingIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :listing_id, :integer
  end
end
