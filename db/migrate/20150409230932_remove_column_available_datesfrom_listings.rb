class RemoveColumnAvailableDatesfromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :available_dates
  end
end
