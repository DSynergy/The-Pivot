class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :listing_categories do |t|
      t.belongs_to :listing, index: true
      t.belongs_to :category, index: true
    end
  end
end
