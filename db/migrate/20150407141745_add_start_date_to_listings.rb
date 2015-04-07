class AddStartDateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :start_date, :hstore
    add_column :listings, :end_date, :hstore
    remove_column :listings, :available_dates
  end
end
