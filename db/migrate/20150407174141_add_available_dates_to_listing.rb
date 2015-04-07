class AddAvailableDatesToListing < ActiveRecord::Migration
  def change
    remove_column :listings, :start_date
    remove_column :listings, :end_date
    add_column :listings, :available_dates, :hstore
  end
end
