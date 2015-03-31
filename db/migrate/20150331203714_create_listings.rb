class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.boolean :private_bathroom, default: true
      t.decimal :price, precision: 6, scale: 2
      t.integer :quantity_available
      t.integer :people_per_unit
      t.hstore :available_dates
      t.integer :user_id
      t.integer :status, default: 0
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
