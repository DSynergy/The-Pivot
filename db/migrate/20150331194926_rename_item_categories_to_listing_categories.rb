class RenameItemCategoriesToListingCategories < ActiveRecord::Migration

  def self.up
    rename_column :listing_categories, :listing_id, :listing_id
    rename_table :listing_categories, :listing_categories
  end

   def self.down
    rename_table :listing_categories, :listing_categories
    rename_column :listing_categories, :listing_id, :listing_id
   end
end
