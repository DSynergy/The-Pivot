class RenameItemCategoriesToListingCategories < ActiveRecord::Migration

  def self.up
    rename_column :item_categories, :item_id, :listing_id
    rename_table :item_categories, :listing_categories
  end

   def self.down
    rename_table :listing_categories, :item_categories
    rename_column :listing_categories, :listing_id, :item_id
   end
end
