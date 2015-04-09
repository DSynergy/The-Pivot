class AddColumnStartDatetoListings < ActiveRecord::Migration
  def change
    add_column :listings, :start_date, :string
    add_column :listings, :end_date, :string
  end
end
