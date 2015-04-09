class AddRetiredToItems < ActiveRecord::Migration
  def change
    add_column :listings, :retired?, :boolean, default: false
  end
end
