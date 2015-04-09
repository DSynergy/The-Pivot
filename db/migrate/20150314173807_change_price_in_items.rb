class ChangePriceInItems < ActiveRecord::Migration
  def change
    remove_column :listings, :price
    add_column :listings, :price, :decimal, precision: 5,  scale: 2
  end
end
