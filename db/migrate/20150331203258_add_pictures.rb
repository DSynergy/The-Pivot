class AddPictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :listing_id
      t.string :url

      t.timestamps null: false
    end
  end
end
